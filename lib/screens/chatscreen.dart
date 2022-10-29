

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {

  String? currentuser;
  String? peeruser;



   ChatScreen({super.key,this.currentuser,this.peeruser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final globalkey=GlobalKey<FormState>();
  String? message;
  String? id;

  createId(){

    if(widget.currentuser.hashCode<=widget.peeruser.hashCode){

      id=widget.currentuser!+"-"+widget.peeruser!;


    }else{

      id=(widget.peeruser.hashCode+widget.currentuser.hashCode) as String?;
    }




  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createId();
  }

  @override
  Widget build(BuildContext context) {

    final appprovider=Provider.of<AppProvider>(context);
    return Scaffold(

      appBar: AppBar(title: Text("chat screen"),),

      body: SingleChildScrollView(
        child: Column(
          children: [

            StreamBuilder(stream:FirebaseFirestore.instance.collection("chats").doc(id).collection("messages").snapshots(),
            
            builder: (context,snapshotdata){

              


              return Container(
                height: 100.0,
                child: ListView.builder(itemCount: snapshotdata.data!.docs.length,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,

                //item count--document length
                
                itemBuilder:(context, index) {
                  DocumentSnapshot documentdata=snapshotdata.data!.docs[index];


                  return Card(
                    child: Container(
                  
                      height: 20,
                  
                      child: Text(
                        documentdata["mesage"],
                  
                  
                  
                      ),
                  
                  
                    ),
                  );
                  
                }),
              );

              



            }),
            Form(
              key: globalkey,
              child: Row(children: [
                  
                Expanded(child: TextFormField(

                  onSaved: (value){
                   message=value;


                  },


                  



                )),
                IconButton(onPressed: (){

                  globalkey.currentState!.save();


                  FirebaseFirestore.instance.collection("chats").doc(id).set({
                    "id":id,


                  });

                  FirebaseFirestore.instance.collection("chats").doc(id).collection("messages").doc().set({

                    "mesage":message,
                    "send by":appprovider.user,
                    "created at":DateTime.now(),



                  });



                }, icon:Icon(Icons.send)),
                  
                  
                  
              ],),
            ),
          ],
        ),
      ),



    );
  }
}