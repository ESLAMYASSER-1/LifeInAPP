import 'package:flutter/material.dart';
import '../Widgets/To_Stream_Feels.dart';

class FeelsFromSalma extends StatefulWidget {
  const FeelsFromSalma({super.key});

  @override
  State<FeelsFromSalma> createState() => _DealsEslamState();
}

bool show = true;
Color custom_green = Color(0xff18DAA3);
Color backgroundColors = Colors.grey.shade100;

class _DealsEslamState extends State<FeelsFromSalma> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Makes the AppBar transparent
          elevation: 0, // Removes the shadow
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(); // Pops the current screen
            },
          ),
        ),
        backgroundColor: backgroundColors,
        body: SafeArea(
          child: Stream_feel("Salma"),
        ),
      );
    });
  }
}
