
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class PostModel{
 String? _url;
  String? _description;
  String? _type;
  String? _username;
  List? _comments;
  int? _likes;

  get url{
  return _url;
  }

  get description{
   return _description;
  }

  get type{
  return _type;
  }

  get username{

    return _username;
}

get comments{

  return _comments;
}

get likes=>_likes;
 PostModel.fromSnapshot(DocumentSnapshot documentSnapshot){
 // doc.data()[""]method is deprcreate use doc.get("") instead
    _url=documentSnapshot.get("imageurls");
    _description=documentSnapshot.get("description");
    _type=documentSnapshot.get("type");
    _username=documentSnapshot.get("name");
    _comments=documentSnapshot.get("comments");
    _likes=documentSnapshot.get("likes");
  }
                                      }