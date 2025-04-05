import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, String>> imageData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  // Fetch images and their metadata
  Future<void> _fetchImages() async {
    setState(() => isLoading = true);
    try {
      // Fetch files from storage
      final storageResponse = await supabase.storage.from('images').list();
      final fileNames = storageResponse.map((file) => file.name).toList();

      // Fetch metadata from the table
      final metadataResponse = await supabase
          .from('image_metadata')
          .select('file_name, description')
          .inFilter('file_name', fileNames);

      final data = storageResponse.map((file) {
        final metadata = metadataResponse.firstWhere(
          (m) => m['file_name'] == file.name,
          orElse: () => {'description': 'No description'},
        );
        return {
          'url': supabase.storage.from('images').getPublicUrl(file.name),
          'name': file.name,
          'description': metadata['description'] as String,
        };
      }).toList();

      setState(() {
        imageData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching images: $e')),
      );
    }
  }

  // Pick and upload an image with user-defined description
  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Show dialog to get description
      String? description = await _showDescriptionDialog(context);
      if (description == null) return; // User canceled

      setState(() => isLoading = true);
      try {
        File imageFile = File(pickedFile.path);
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

        // Upload the image
        await supabase.storage.from('images').upload(fileName, imageFile);

        // Save metadata to the table
        await supabase.from('image_metadata').insert({
          'file_name': fileName,
          'description': description.isEmpty ? 'No description' : description,
        });

        // Refresh the gallery
        await _fetchImages();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully!')),
        );
      } catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }
  }

  // Dialog to get description from user
  Future<String?> _showDescriptionDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Description'),
          content: TextField(
            controller: controller,
            decoration:
                const InputDecoration(hintText: 'e.g., Sunset at beach'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, controller.text), // Submit
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : imageData.isEmpty
              ? const Center(child: Text('No images found. Upload one!'))
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: imageData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageDetailPage(
                              imageUrl: imageData[index]['url']!,
                              imageName: imageData[index]['name']!,
                              description: imageData[index]['description']!,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Image.network(
                            imageData[index]['url']!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Error loading image'));
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                imageData[index]['description']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadImage,
        tooltip: 'Upload Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

// Full-screen image view with name and description
class ImageDetailPage extends StatelessWidget {
  final String imageUrl;
  final String imageName;
  final String description;

  const ImageDetailPage({
    super.key,
    required this.imageUrl,
    required this.imageName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
      ),
      body: Stack(
        children: [
          Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('Error loading image'));
              },
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Name: $imageName',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Description: $description',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
