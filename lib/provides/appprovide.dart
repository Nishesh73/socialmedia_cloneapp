//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone_app/models/postmodel.dart';
import 'package:instagram_clone_app/services/firebaseservice.dart';

class AppProvider with ChangeNotifier {
  String? user;

  List<PostModel> posts = [];

  FirebaseService firebaseService = FirebaseService();

  AppProvider() {
    gettPosts();
  }

  Future signInwithGoogle() async {

   

    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final googlecredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    return FirebaseAuth.instance
        .signInWithCredential(googlecredential)
        .then((value) {
      user = value.user!.displayName;

      FirebaseFirestore.instance
          .collection("users")
          .doc(value.user!.displayName)
          .set(
        {
          "id": value.user!.uid,
          "name": value.user!.displayName,
          "email": value.user!.email,
          "url":"",
        },
        SetOptions(merge: true),
      );
    });

  

  }

  gettPosts() async {
    posts = await firebaseService.getPost();
  }
}
