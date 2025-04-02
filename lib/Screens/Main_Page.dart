import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lifeinapp/data/firestor.dart';
import 'package:line_icons/line_icons.dart';

import '../Widgets/Beautiful Button.dart';
import '../Widgets/To_Do_Stream_notes.dart';
import '../Widgets/To_Do_card.dart';
import '../model/notes_model.dart';
import 'To_Do_List_Done.dart';
import 'To_Do_List_not_Done.dart';
import 'add_note_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Color custom_green = Color(0xff18DAA3);
Color backgroundColors = Colors.grey.shade100;

TextStyle get beautifulTextStyle => TextStyle(
      fontFamily: GoogleFonts.playfairDisplay().fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.deepPurple[700],
      letterSpacing: 1.2,
      shadows: [
        Shadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(2, 2),
          blurRadius: 4,
        ),
      ],
    );

class Main_Page extends StatefulWidget {
  @override
  PagesState createState() => PagesState();
}

bool show = true;

class PagesState extends State<Main_Page> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _Pages = <Widget>[
    const Text(
      'Likes',
      style: optionStyle,
    ),
    const Text(
      'Search',
      style: optionStyle,
    ),
    Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Do not pity the dead, Harry, pity the living, and above all those who live without love.',
              style: beautifulTextStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotDoneList(),
                  ));
                },
                icon: Icons.directions_run,
                text: 'NotDone',
                colorm: Colors.blue.shade300,
                colors: Colors.blue.shade700,
              ),
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DoneList(),
                  ));
                },
                icon: Icons.done_outline_rounded,
                text: 'Done',
                colorm: Colors.green.shade300,
                colors: Colors.green.shade700,
              ),
            ],
          ),
        ],
      );
    }),
    const Text(
      'Profile',
      style: optionStyle,
    ),
    const Text(
      'Profile',
      style: optionStyle,
    ),
    Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Do not pity the dead, Harry, pity the living, and above all those who live without love.',
              style: beautifulTextStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotDoneList(),
                  ));
                },
                icon: Icons.man_2,
                text: 'Eslam',
                colorm: Colors.blue.shade300,
                colors: Colors.blue.shade700,
              ),
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DoneList(),
                  ));
                },
                icon: Icons.woman_2,
                text: 'Salma',
                colorm: Colors.pink.shade300,
                colors: Colors.pink.shade700,
              ),
            ],
          ),
        ],
      );
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: Center(
          child: Text(
            'Life In App',
            style: beautifulTextStyle.copyWith(color: Colors.indigo),
          ),
        ),
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
