

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
              height: 600.0,
              width: 500.0,

              child: ListView(children:streamdata.data!.docs.map((DocumentSnapshot snapshot){

                List listdata=snapshot.get("friends");

                return Container(
                  height: 300,
                  width: 200,
                  child: ListView.builder(

                    itemCount:listdata.length ,
                    
                    itemBuilder: (context, index) {

                      return ListTile(
                        leading:Text(listdata[index]+"\nsend fnd reqst") ,
                        

                        
                        trailing:Container(
                          
                          width: 250,
                          child: Row(children: [

                            SizedBox(width: 60.0,),

                            Expanded(
                              child: MaterialButton(onPressed: (){

                                FirebaseFirestore.instance.collection("users").doc(approvider.user).set({

                                  "Friends":FieldValue.arrayUnion([listdata[index]]),


                                }, 

                                SetOptions(merge: true),
                                
                                );

                                FirebaseFirestore.instance.collection("users").doc(listdata[index]).set({

                                  "Friends":FieldValue.arrayUnion([approvider.user]),
                                },
                                
                                SetOptions(merge: true));

                                FirebaseFirestore.instance.collection("temporaryfriendlist").doc(approvider.user).update({

                                  "friends":FieldValue.arrayRemove([listdata[index]]),


                                });



                              },

                              
                              child: Text("confirm"),
                              color:Colors.red,
                              
                              
                              ),
                            ),
                            Expanded(
                              child: MaterialButton(onPressed: (){},
                              
                              child: Text("reject"),
                              color: Colors.blue,
                              
                              
                              ),
                            )



                          ],),
                        ) ,
                      );
                      
                    }),
                );





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