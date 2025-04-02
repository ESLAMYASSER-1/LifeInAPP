import 'package:flutter/material.dart';

import '../Widgets/To_Do_Stream_notes.dart';
import 'add_note_screen.dart';

class DoneList extends StatefulWidget {
  const DoneList({super.key});

  @override
  State<DoneList> createState() => _DoneListState();
}

bool show = true;
Color custom_green = Color(0xff18DAA3);
Color backgroundColors = Colors.grey.shade100;

class _DoneListState extends State<DoneList> {
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
                builder: (context) => Add_creen(),
              ));
            },
            backgroundColor: custom_green,
            child: Icon(Icons.add, size: 30),
          ),
        ),
        body: SafeArea(
          child: Stream_note(true),
        ),
      );
    });
  }
}
