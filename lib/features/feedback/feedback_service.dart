import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FeedbackService {
  FeedbackService() {
    Firebase.initializeApp();
  }
  Future<String> createComment(String comment) async {
    try {
      DateTime dateTime = DateTime.now().toUtc();
      User user = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('comments');
      users.add({
        'userid': user.uid,
        'email': user.email,
        'comment': comment,
        'createdAt': dateTime,
      });
      return '';
    } catch (e) {
      print(e);
    }
  }

  List temp = [];
  Future getComments() async {
    List commentsList = [];
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("comments");
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          temp.add(result.data());
          commentsList.add(result.data());
        }
      });
      return commentsList;
    } catch (e) {
      debugPrint("Error - $e");
      return e;
    }
  }

  void refresh() async {
    temp.clear();
    await getComments();
  }
}
