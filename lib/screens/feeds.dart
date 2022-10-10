

//import 'dart:html';
import 'dart:io';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/widget/postwidget.dart';
import 'package:provider/provider.dart';
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

 


  

  @override
  Widget build(BuildContext context) {
    final approvider=Provider.of<AppProvider>(context);
    return Scaffold(

      appBar: AppBar(
        
        title: Text("feed"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: (){
           ImagePicker().pickVideo(source: ImageSource.gallery).then((imagetaken) {

      var tempfile=File(imagetaken!.path);

      if(tempfile!=null){

        setState(() {

          pickimage=tempfile;
          
        });

       }
 } );

       Reference reference=FirebaseStorage.instance.ref().child("postsfolder").child(uids.v4().toString());

       UploadTask uploadimage=reference.putFile(pickimage!);
       uploadimage.whenComplete(() {

        reference.getDownloadURL().then((imageurl) {


          FirebaseFirestore.instance.collection("posts").doc().set({
            "imageurls":imageurl,
            "type":"video is good",
            "description":"video is marvelous",
            "name":approvider.user,


          });
        });


       } );

       

    




          }, icon: Icon(Icons.video_call)),
          IconButton(onPressed: (){
             ImagePicker().pickImage(source: ImageSource.gallery).then((imagetaken) {

      var tempfile=File(imagetaken!.path);

      if(tempfile!=null){

        setState(() {

          pickimage=tempfile;
          
        });

       }
 } );

       Reference reference=FirebaseStorage.instance.ref().child("postsfolder").child(uids.v4().toString());

       UploadTask uploadimage=reference.putFile(pickimage!);
       uploadimage.whenComplete(() {

        reference.getDownloadURL().then((imageurl) {


          FirebaseFirestore.instance.collection("posts").doc().set({
            "imageurls":imageurl,
            "type":"image",
            "description":"image is beautiful",
            "name":approvider.user,


          });
        });


       } );

           
          }, icon: Icon(Icons.upload_file)),
        ],

        

      ),

      body: SingleChildScrollView(child: Column(

        children: [

          Text("first line of column"),

          Column(children: 

            approvider.posts.map((results) => PostWidget(postModel: results)).toList(),
          


          )


        ],


      )
      ),


    );
  }
}