//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MyProfile extends StatefulWidget {
  String? name;
  MyProfile({super.key, this.name});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Uuid uid = Uuid();
  @override
  Widget build(BuildContext context) {
    final approver=Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("name", isEqualTo: widget.name)
                      .snapshots(),
                  builder: (context, snapshots) {
                    return Column(
                      children: snapshots.data!.docs.map((result) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ImagePicker()
                                        .pickImage(source: ImageSource.gallery)
                                        .then((image) {
                                      var galimage = File(image!.path);

                                      Reference reference = FirebaseStorage
                                          .instance
                                          .ref()
                                          .child("postfolder")
                                          .child(uid.v4().toString());
                                    UploadTask uploadTask=  reference.putFile(galimage);
                                    uploadTask.whenComplete(() { 

                                      reference.getDownloadURL().then((resulurl){
                                        FirebaseFirestore.instance.collection("users").doc(approver.user).update({
                                          "url":resulurl,

                                        },
                                        
                                        
                                        );
                                       
                                      });


                                    } );

                                      
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(15.0),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(result["url"]),
                                      radius: 60.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(result["name"],style: TextStyle(fontSize:15.0 ,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 200.0,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("posts")
                                      .where("name", isEqualTo: widget.name)
                                      .snapshots(),
                                  builder: (context, snapshots) {
                                    return GridView(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              
                                              crossAxisSpacing: 20.0),
                                      children:
                                          snapshots.data!.docs.map((result) {
                                            

                                        return  Image.network(
                                            result["imageurls"]);


                                      }).toList(),
                                    );
                                  }),
                            )
                          ],
                        );
                      }).toList(),
                    );
                  }),
            ],
          )
        ],
      )),
    );
  }
}
