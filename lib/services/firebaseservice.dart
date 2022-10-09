import "package:cloud_firestore/cloud_firestore.dart";

import '../models/postmodel.dart';
class FirebaseService{


  Future<List<PostModel>> getPost(){

    List<PostModel> post=[];

    return FirebaseFirestore.instance.collection("posts").get().then((result){


      for(DocumentSnapshot documentsnapshot in result.docs){

        post.add(PostModel.fromSnapshot(documentsnapshot));




      }

      return post;
 




    } );




  }








}