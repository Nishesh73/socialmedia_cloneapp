import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/screens/chatscreen.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

class MyFriendList extends StatefulWidget {
  const MyFriendList({super.key});

  @override
  State<MyFriendList> createState() => _MyFriendListState();
}

class _MyFriendListState extends State<MyFriendList> {
  @override
  Widget build(BuildContext context) {
    final approvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("friendlist"),
        gradient: LinearGradient(colors: [
          Colors.red,
          Colors.white,
          Colors.black,
        ]),
      ),
      body: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("name", isEqualTo: approvider.user)
                  .snapshots(),
              builder: (context, snapshot) {
                return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot documentSnapshot) {
                    List data = documentSnapshot.get("Friends");
                    return Column(
                      children: data.map((e) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            currentuser: approvider.user,
                                            peeruser: e,
                                          )));
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 30.0),
                                child: Text("chat with" + "   " + e)));
                      }).toList(),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
