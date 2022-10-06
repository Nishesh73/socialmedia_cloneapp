

//import 'dart:html';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';


class MyFeeds extends StatefulWidget {
  const MyFeeds({super.key});

  @override
  State<MyFeeds> createState() => _MyFeedsState();
}

class _MyFeedsState extends State<MyFeeds> {
  File? pickimage;
  var uids=Uuid();


  uploadContent(){

    ImagePicker().pickImage(source: ImageSource.gallery).then((imagetaken) {

      
        pickimage=File(imagetaken!.path);
        
       } );

       Reference reference=FirebaseStorage.instance.ref().child("postsfolder").child(uids.v4().toString());

       UploadTask uploadimage=reference.putFile(pickimage!);
       uploadimage.whenComplete(() {

        reference.getDownloadURL().then((imageurl) {


          FirebaseFirestore.instance.collection("users").doc().set({
            "imageurls":imageurl


          });
        });


       } );

    





  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        
        title: Text("feed"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: (){
            uploadContent();
          }, icon: Icon(Icons.upload_file)),
        ],

        

      ),


    );
  }
}