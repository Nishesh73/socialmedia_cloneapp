import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyComment extends StatefulWidget {
  List? comments;
  String? descriptions;
  MyComment({super.key, this.comments, this.descriptions});
  @override
  State<MyComment> createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
  TextEditingController _textEditingController=TextEditingController();
  final globalkey = GlobalKey<FormState>();
  List? sendcomment = [];
  String? comment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("comments"),
        gradient:
            LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.comments!.map((result) => Text(result)).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 500.0),
            child: ListTile(
              leading: Form(
                key: globalkey,
                child: Container(
                  width: 200.0,
                  child: TextFormField(
                    controller:_textEditingController ,

                   
                    
                    onSaved: (value) {
                      comment = value;
                      _textEditingController.clear();
                    },
                  ),
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    globalkey.currentState!.save();
                    sendcomment?.add(comment);

                    FirebaseFirestore.instance
                        .collection("posts")
                        .doc(widget.descriptions)
                        .update({
                      "comments": FieldValue.arrayUnion(sendcomment!),
                    });
                  },
                  icon: Icon(MdiIcons.send)),
            ),
          )
        ],
      )),
    );
  }
}
