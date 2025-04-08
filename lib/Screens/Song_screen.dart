import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lifeinapp/data/firestor.dart';

class SongListPage extends StatefulWidget {
  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentSongUrl;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _songUrlController = TextEditingController();

  @override
  void dispose() {
    _audioPlayer.dispose();
    _nameController.dispose();
    _imageController.dispose();
    _songUrlController.dispose();
    super.dispose();
  }

  void _showAddSongDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Song'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Song Name'),
              ),
              TextField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: _songUrlController,
                decoration: InputDecoration(labelText: 'Song URL (HTTPS only)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final image = _imageController.text.trim();
              final songUrl = _songUrlController.text.trim();

              if (name.isNotEmpty && image.isNotEmpty && songUrl.isNotEmpty) {
                if (!songUrl.startsWith('https://')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please use an HTTPS URL for the song')),
                  );
                  return;
                }

                try {
                  await Firestore_Datasource().addSong(name, image, songUrl);
                  _nameController.clear();
                  _imageController.clear();
                  _songUrlController.clear();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Song added successfully!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$e')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill all fields')),
                );
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _playSong(String songUrl, String songName) async {
    try {
      print('Attempting to play: $songUrl');
      await _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(songUrl),
          tag: MediaItem(
            id: songUrl,
            title: songName,
            album: "My App",
            artUri: Uri.parse('https://via.placeholder.com/150'),
          ),
        ),
      );
      await _audioPlayer.play();
      setState(() => _currentSongUrl = songUrl);
    } catch (e, stackTrace) {
      print('Error playing song: $e\nStack trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing song: $e')),
      );
    }
  }

  void _showDeleteDialog(String songId, String songName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Song'),
        content: Text('Are you sure you want to delete "$songName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await Firestore_Datasource().deleteSong(songId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Song deleted successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting song: $e')),
                );
              }
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore_Datasource().getSongs(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final songs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index].data() as Map<String, dynamic>;
                    final songId = songs[index].id;
                    final name = song['name'] as String;
                    final image = song['image'] as String;
                    final songUrl = song['songurl'] as String;

                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      title: Text(name),
                      onTap: () async {
                        if (_currentSongUrl == songUrl) {
                          await _audioPlayer.pause();
                          setState(() => _currentSongUrl = null);
                        } else {
                          await _playSong(songUrl, name);
                        }
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _currentSongUrl == songUrl
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteDialog(songId, name),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () async {
                    await _audioPlayer.stop();
                    setState(() => _currentSongUrl = null);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSongDialog,
        child: Icon(Icons.add),
        tooltip: 'Add Song',
      ),
    );
  }
}
