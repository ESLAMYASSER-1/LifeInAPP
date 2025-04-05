import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../Widgets/Beautiful Button.dart';
import '../Widgets/Jar Widget.dart';
import 'Deals_Eslam.dart';
import 'Deals_Salma.dart';
import 'Feels_From_Eslam.dart';
import 'Feels_From_Salma.dart';
import 'To_Do_List_Done.dart';
import 'To_Do_List_not_Done.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_feel_screen.dart';

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
            child: Column(
              children: [
                Text(
                  'Do not pity the dead, Harry, pity the living, and above all those who live without love.',
                  style: beautifulTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '                                   Dumbledore.',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
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
    Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'So when the time comes the boy must die?\nYes, yes he must die.\nYou\'ve kept him alive so that he can die at the proper moment.\nYou\'ve been raising him like a pig for slaughter\nDon’t tell me now that you\'ve grown to care for the boy\nLilly ?\nAfter all this time?\nAlways!',
                  style: beautifulTextStyle.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '                   Dumbledore     Severus Snape',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_feel(
                      who: "Eslam",
                    ),
                  ));
                },
                icon: Icons.man_2,
                text: 'For Eslam',
                colorm: Colors.blue.shade100,
                colors: Colors.blue.shade700,
              ),
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_feel(
                      who: "Salma",
                    ),
                  ));
                },
                icon: Icons.woman_2,
                text: 'For Salma',
                colorm: Colors.pink.shade100,
                colors: Colors.pink.shade700,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FeelsFromSalma(),
                  ));
                },
                icon: Icons.man_2,
                text: 'From Eslam',
                colorm: Colors.pink.shade700,
                colors: Colors.pink.shade100,
              ),
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FeelsFromEslam(),
                  ));
                },
                icon: Icons.woman_2,
                text: 'From Salma',
                colorm: Colors.blue.shade700,
                colors: Colors.blue.shade100,
              ),
            ],
          ),
        ],
      );
    }),
    JarWidget(),
    Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'Always the tone of surprise.',
                  style: beautifulTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '                Hermione Granger   Ron Weasley.',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BeautifulButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DealsEslam(),
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
                    builder: (context) => DealsSalma(),
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
                  icon: LineIcons.list,
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
