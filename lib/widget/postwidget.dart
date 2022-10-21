

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_app/models/postmodel.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatefulWidget {
  final PostModel postModel;
  const PostWidget({super.key,required this.postModel});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  VideoPlayerController? videoPlayerController;

  List? temporaryfriendList=[];

  videoPlay(){
    if(widget.postModel.type=="video"){

       videoPlayerController=VideoPlayerController.network(widget.postModel.url);

       setState(() {
       videoPlayerController!.initialize();
       videoPlayerController!.play();
         
       });
       


    }
    else{

      return null;
    }

   






  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlay();
  }





 

  
  @override
  Widget build(BuildContext context) {
    final approvider=Provider.of<AppProvider>(context);
    return Container(

      child: Column(
        children: [


       
            ListTile(
              leading: Text(widget.postModel.username),
              trailing: widget.postModel.username==approvider.user?null:
              
              GestureDetector(
                onTap: (){

                  String? temporaryfriend=approvider.user;//google signin wala mah
                  //widget.postModel.username==hamile friend request pathako manxe

                  temporaryfriendList?.add(temporaryfriend);

                  FirebaseFirestore.instance.collection("temporaryfriendlist").doc(widget.postModel.username).set({
                   "friends":FieldValue.arrayUnion(temporaryfriendList!),


                  });






                },
                
                
                child: Text("add friend")),

            ),

          
         widget.postModel.type=="image"? Image.network(widget.postModel.url):
         
         Container(
          child: AspectRatio(aspectRatio: 16/7,

          child: VideoPlayer(videoPlayerController!),

          
          ),


         ),


        ],
      ),



    );
  }
}