import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/screens/feeds.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File? pickimage;
  String? descript;
  var uids = Uuid();

  @override
  Widget build(BuildContext context) {
    final approvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    onChanged: ((value) {
                      setState(() {
                        descript = value;
                      });
                    }),
                  )),
                ],
              ),
            ),
            MaterialButton(
              elevation: 10,
              onPressed: () {
                ImagePicker()
                    .pickVideo(source: ImageSource.gallery)
                    .then((imagetaken) {
                  var tempfile = File(imagetaken!.path);

                  if (tempfile != null) {
                    setState(() {
                      pickimage = tempfile;
                    });
                  }
                });

                Reference reference = FirebaseStorage.instance
                    .ref()
                    .child("postsfolder")
                    .child(uids.v4().toString());

                if (pickimage != null) {
                  UploadTask uploadimage = reference.putFile(pickimage!);

                  uploadimage.whenComplete(() {
                    reference.getDownloadURL().then((imageurl) {
                      FirebaseFirestore.instance
                          .collection("posts")
                          .doc(descript)
                          .set({
                        "imageurls": imageurl,
                        "type": "video",
                        "description": descript,
                        "name": approvider.user,
                        "comments": [],
                        "likes": 0,
                      });
                    });
                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFeeds()));
                  });
                }
              },
              child: Text("upload video"),
              color: Colors.yellow,
              shape: Border.all(width: 2.0, color: Colors.black),
            ),
            MaterialButton(
              elevation: 10,
              onPressed: () {
                ImagePicker()
                    .pickImage(source: ImageSource.gallery)
                    .then((imagetaken) {
                  var tempfile = File(imagetaken!.path);

                  if (tempfile != null) {
                    setState(() {
                      pickimage = tempfile;
                    });
                  }
                });

                Reference reference = FirebaseStorage.instance
                    .ref()
                    .child("postsfolder")
                    .child(uids.v4().toString());
                if (pickimage != null) {
                  UploadTask uploadimage = reference.putFile(pickimage!);

                  uploadimage.whenComplete(() {
                    reference.getDownloadURL().then((imageurl) {
                      FirebaseFirestore.instance
                          .collection("posts")
                          .doc(descript)
                          .set({
                        "imageurls": imageurl,
                        "type": "image",
                        "description": descript,
                        "name": approvider.user,
                        "comments": [],
                        "likes": 0,
                      });
                    });

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFeeds()));
                  });
                }
              },
              child: Text("upload image"),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
