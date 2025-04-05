import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class JarWidget extends StatefulWidget {
  const JarWidget({super.key});

  @override
  _JarWidgetState createState() => _JarWidgetState();
}

class _JarWidgetState extends State<JarWidget> with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  String _selectedSentence = '';
  bool _isShaking = false;
  List<String> _sentences = [];

  @override
  void initState() {
    super.initState();

    // Initialize shake animation
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );

    // Initialize fade animation
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);

    // Fetch sentences from Firestore
    FirebaseFirestore.instance.collection('sentences').get().then((snapshot) {
      setState(() {
        _sentences = snapshot.docs.map((doc) => doc['text'] as String).toList();
      });
    }).catchError((e) {
      print('Error fetching sentences: $e');
    });
  }

  void _shakeJar() {
    if (_sentences.isEmpty) return;

    setState(() {
      _isShaking = true;
      _selectedSentence = '';
    });

    _shakeController.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 2), () {
      _shakeController.stop();
      setState(() {
        _isShaking = false;
        _selectedSentence = _sentences[Random().nextInt(_sentences.length)];
      });
      _fadeController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _isShaking
                  ? _shakeAnimation
                  : const AlwaysStoppedAnimation(0),
              child: Image.asset(
                'images/jar.png',
                width: 350,
                height: 350,
              ),
            ),
            const SizedBox(height: 20),
            if (_sentences.isEmpty)
              const Text(
                'Loading sentences...',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              )
            else if (_selectedSentence.isNotEmpty)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Expanded(
                    child: Text(
                      _selectedSentence,
                      style: const TextStyle(fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sentences.isEmpty ? null : _shakeJar,
              child: const Text(
                'Shake the Jar',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
