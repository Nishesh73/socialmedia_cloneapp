

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:provider/provider.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  Widget build(BuildContext context) {
    final approvider=Provider.of<AppProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(child: 

      Column(
        children: [
          StreamBuilder<QuerySnapshot> (
            stream:FirebaseFirestore.instance.collection("temporaryfriendlist").where("name", isEqualTo: approvider.user).snapshots(),
            builder: (context,streamdata){

            return Container(

              child: ListView(children:streamdata.data!.docs.map((DocumentSnapshot snapshot){

                List listdata=snapshot.get("friends");

                return ListView.builder(

                  itemCount:listdata.length ,
                  
                  itemBuilder: (context, index) {

                    return ListTile(
                      leading:Text("friend request from") ,
                      trailing:Text(listdata[index]) ,
                    );
                    
                  });





              }
              
              
              ).toList(),


              
              
              ),





            );


          })


        ],
      )
      ),


    );
  }
}