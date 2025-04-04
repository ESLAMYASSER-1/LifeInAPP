import 'package:flutter/material.dart';

class PrettyTextCard extends StatelessWidget {
  final String text;

  const PrettyTextCard({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Adds a shadow for depth
      child: Padding(
        padding: const EdgeInsets.all(
            16.0), // Adds 16 pixels of padding on all sides
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20, // Larger text for readability
            fontWeight: FontWeight.bold, // Bold text for emphasis
            color: Colors.black, // Black text for contrast
          ),
        ),
      ),
    );
  }
}
