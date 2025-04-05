import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifeinapp/model/notes_model.dart';
import 'package:uuid/uuid.dart';

import '../model/deals_model.dart';
import '../model/fealings_model.dart';

class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> AddNote(String subtitle, String title, int image) async {
    try {
      var uuid = Uuid().v4();
      DateTime data = new DateTime.now();
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'subtitle': subtitle,
        'isDon': false,
        'image': image,
        'time': '${data.month}/${data.day}-${data.hour}:${data.minute}',
        'title': title,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['subtitle'],
          data['time'],
          data['image'],
          data['title'],
          data['isDon'],
        );
      }).toList();
      return notesList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        // .collection('users')
        // .doc(_auth.currentUser!.uid)
        .collection('notes')
        .where('isDon', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> isdone(String uuid, bool isDon) async {
    try {
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'isDon': isDon});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> Update_Note(
      String uuid, int image, String title, String subtitle) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> delet_note(String uuid) async {
    try {
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> AddDeal(
      String subtitle, bool isDon, String title, int image) async {
    try {
      var uuid = Uuid().v4();
      DateTime data = new DateTime.now();
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('deals')
          .doc(uuid)
          .set({
        'id': uuid,
        'subtitle': subtitle,
        'isDon': isDon,
        'image': image,
        'time': '${data.month}/${data.day}-${data.hour}:${data.minute}',
        'title': title,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  List getDeals(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Deal(
          data['id'],
          data['subtitle'],
          data['time'],
          data['image'],
          data['title'],
          data['isDon'],
        );
      }).toList();
      return notesList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> streamDeals(bool isDone) {
    return _firestore
        // .collection('users')
        // .doc(_auth.currentUser!.uid)
        .collection('deals')
        .where('isDon', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> isdoneDeals(String uuid, bool isDon) async {
    try {
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('deals')
          .doc(uuid)
          .update({'isDon': isDon});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> Update_Deals(
      String uuid, int image, String title, String subtitle) async {
    try {
      DateTime data = new DateTime.now();
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('deals')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> delet_Deals(String uuid) async {
    try {
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('deals')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> AddFeel(String text, String who) async {
    try {
      var uuid = Uuid().v4();
      DateTime data = new DateTime.now();
      await _firestore
          // .collection('users')
          // .doc(_auth.currentUser!.uid)
          .collection('fealing_$who')
          .doc(uuid)
          .set({
        'id': uuid,
        'text': text,
        'time': '${data.month}/${data.day}-${data.hour}:${data.minute}',
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  List getFeel(AsyncSnapshot snapshot) {
    try {
      final feelsList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Feel(
          data['id'],
          data['text'],
          data['time'],
        );
      }).toList();
      return feelsList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> streamFeel(String who) {
    return _firestore
        // .collection('users')
        // .doc(_auth.currentUser!.uid)
        .collection('fealing_$who')
        .snapshots();
  }
}
