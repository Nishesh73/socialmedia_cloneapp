


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AppProvider with ChangeNotifier{

  AppProvider(){


  }


  

   signInwithGoogle() async{

    


    GoogleSignInAccount? googleSignInAccount=await GoogleSignIn().signIn();
    
    GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount!.authentication;
    
    
    final googlecredential=GoogleAuthProvider.credential(accessToken:googleSignInAuthentication.accessToken ,
    
    idToken:googleSignInAuthentication.idToken );

    return FirebaseAuth.instance.signInWithCredential(googlecredential).then((value){

      FirebaseFirestore.instance.collection("users").doc(value.user!.displayName).set({

        "id":value.user!.uid,
        "name":value.user!.displayName,
        "email":value.user!.email






      });

   

   
    


    






    });





  }






}