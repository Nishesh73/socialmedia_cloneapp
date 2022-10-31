

//import 'dart:html';
import 'dart:io';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/screens/detailscreen.dart';
import 'package:instagram_clone_app/screens/friendlistscreen.dart';
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
            Navigator.push(context, MaterialPageRoute(builder: (context){

              return DetailScreen();


            }));


          }, icon: Icon(Icons.add)),
          IconButton(onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context){
              return MyFriendList();


            }) );

          }, icon: Icon(Icons.message)),


          
        ],

        

      ),

      body: SingleChildScrollView(child: Column(

        children: [

          Text("hi"),

          Column(children: 

            approvider.posts.map((results) => PostWidget(postModel: results)).toList(),
          


          )


        ],


      )
      ),


    );
  }
}