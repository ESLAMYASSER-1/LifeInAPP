import 'package:flutter/material.dart';
import 'package:lifeinapp/Widgets/To_Stream_Deals.dart';

import 'add_deal_screen.dart';

class DealsSalma extends StatefulWidget {
  const DealsSalma({super.key});

  @override
  State<DealsSalma> createState() => _DealsSalmaState();
}

bool show = true;
Color custom_green = Color(0xff18DAA3);
Color backgroundColors = Colors.grey.shade100;

class _DealsSalmaState extends State<DealsSalma> {
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
        floatingActionButton: Visibility(
          visible: show,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Add_Deal(),
              ));
            },
            backgroundColor: custom_green,
            child: Icon(Icons.add, size: 30),
          ),
        ),
        body: SafeArea(
          child: Stream_deals(true),
        ),
      );
    });
  }
}
