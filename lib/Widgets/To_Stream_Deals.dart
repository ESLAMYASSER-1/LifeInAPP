import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/firestor.dart';
import 'Deals_Card.dart';
import 'To_Do_card.dart';

class Stream_deals extends StatelessWidget {
  bool done;
  Stream_deals(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore_Datasource().streamDeals(done),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final dealslist = Firestore_Datasource().getDeals(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final deal = dealslist[index];
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    Firestore_Datasource().delet_Deals(deal.id);
                  },
                  child: Deals_Widget(deal));
            },
            itemCount: dealslist.length,
          );
        });
  }
}
