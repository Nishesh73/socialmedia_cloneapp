

import 'package:flutter/cupertino.dart';
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

  videoPlay(){
    if(widget.postModel.type=="video"){

       videoPlayerController=VideoPlayerController.network(widget.postModel.url);

       setState(() {
       videoPlayerController!.initialize();
       videoPlayerController!.play();
         
       });
       


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
          Text(approvider.user!),


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