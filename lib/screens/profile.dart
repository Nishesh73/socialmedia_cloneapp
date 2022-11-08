import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyProfile extends StatefulWidget {
  String? name;
  MyProfile({super.key, this.name});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
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
                                //circleavatar

                                Text(result["name"]),
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
                                        return Image.network(
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
