import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/firestor.dart';
import 'To_Do_card.dart';

class Stream_feel extends StatelessWidget {
  String who;
  Stream_feel(this.who, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore_Datasource().streamFeel(who),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final feelslist = Firestore_Datasource().getFeel(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final feel = feelslist[index];
              print(feel);
              return Task_Widget(feel);
            },
            itemCount: feelslist.length,
          );
        });
  }
}
