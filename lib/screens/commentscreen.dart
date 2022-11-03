import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyComment extends StatefulWidget {
  List? comments;
  String? descriptions;
  MyComment( {super.key,this.comments,this.descriptions});
  @override
  State<MyComment> createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
  final globalkey=GlobalKey<FormState>();
  List? sendcomment=[];
  String? comment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(child:
      Column(
        children: [
          Column(
            children: widget.comments!.map((result) => Text(result)).toList(),
),

          Container(
            margin:EdgeInsets.only(top: 600) ,
            child: ListTile(leading:
            Form(
              key: globalkey,
              child: Container(
                width: 200.0,
                child: TextFormField(
                 onSaved: (value){
                  comment=value;
                 
                  
            
            
                 },
            
            
                ),
              ),
            ) ,trailing:IconButton(onPressed: (){

              globalkey.currentState!.save();
              sendcomment?.add(comment);

              FirebaseFirestore.instance.collection("posts").doc(widget.descriptions).update({
                

                "comments":FieldValue.arrayUnion(sendcomment!),



              });


            }, icon: Icon(MdiIcons.send)) ,),
          )

        ],
      )


      ),
    );
  }
}

