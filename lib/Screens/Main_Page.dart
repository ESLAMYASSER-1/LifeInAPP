import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lifeinapp/data/firestor.dart';
import 'package:line_icons/line_icons.dart';

import '../Widgets/To_Do_card.dart';
import '../model/notes_model.dart';
import 'add_note_screen.dart';

Color custom_green = Color(0xff18DAA3);
Color backgroundColors = Colors.grey.shade100;

class Main_Page extends StatefulWidget {
  @override
  PagesState createState() => PagesState();
}

class PagesState extends State<Main_Page> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _Pages = <Widget>[
    Builder(builder: (context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_creen(),
            ));
          },
          backgroundColor: custom_green,
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: StreamBuilder<Object>(
            stream: Firestore_Datasource().stream(true),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final notelist = Firestore_Datasource().getNotes(snapshot);
              return SafeArea(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  final note = notelist[index];
                  print(notelist.length);
                  return Task_Widget(note);
                },
                itemCount: notelist.length,
              ));
            }),
      );
    }),
    const Text(
      'Likes',
      style: optionStyle,
    ),
    const Text(
      'Search',
      style: optionStyle,
    ),
    const Text(
      'Profile',
      style: optionStyle,
    ),
    const Text(
      'Profile',
      style: optionStyle,
    ),
    const Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('Life In App'),
      ),
      body: Center(
        child: _Pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 0,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.photoVideo,
                  text: 'Album',
                ),
                GButton(
                  icon: LineIcons.music,
                  text: 'Music',
                ),
                GButton(
                  icon: LineIcons.clipboardList,
                  text: 'To Do',
                ),
                GButton(
                  icon: LineIcons.heartbeat,
                  text: 'Feelings',
                ),
                GButton(
                  icon: LineIcons.moon,
                  text: 'Wishes',
                ),
                GButton(
                  icon: LineIcons.clipboardList,
                  text: 'Deals',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class To_do_list_card {}
