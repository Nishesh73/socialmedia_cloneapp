import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_app/models/postmodel.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/screens/commentscreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
 DocumentSnapshot? documentSnapshot;
  
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
  widget.postModel.type=="image"? GestureDetector(
    onDoubleTap: (() {
      int like=widget.postModel.likes;
      FirebaseFirestore.instance.collection("posts").doc(widget.postModel.description).update({

        "likes":like+=1,
      });


      
    }),
    
    child: Image.network(widget.postModel.url)):
         
         Container(
          child: AspectRatio(aspectRatio: 16/7,

          child: VideoPlayer(videoPlayerController!),
   ),
     ),

   Row(children: [

    Column(
      children: [
        IconButton(onPressed: (){

          StreamBuilder(stream:FirebaseFirestore.instance.collection("posts").snapshots(), 
          builder:(context,snapshots){
            return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context,index){
                DocumentSnapshot documentSnapshot=snapshots.data!.docs[index];

                return Column(
                  children: [
                   
                   Text(documentSnapshot["likes"]),
                  ],

                );
              });


          } ,);
          


        }, 
        icon: Icon(MdiIcons.heart)),

        

        
      ],
    ),
    SizedBox(width: 10.0,),
    IconButton(onPressed: (){

      Navigator.push(context,MaterialPageRoute(builder: (context)=>MyComment(comments:widget.postModel.comments,descriptions: widget.postModel.description,)) );



    }, icon: Icon(MdiIcons.commentAlert)),

],),

  ],
      ),

 );

 }
}