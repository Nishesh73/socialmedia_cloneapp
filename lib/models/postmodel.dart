
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PostModel{

  String? _url;
  String? _description;
  String? _type;

  get url{

    return _url;
  }

  get description{

    return _description;
  }

  get type{


    return _type;
  } 


  PostModel.fromSnapshot(DocumentSnapshot documentSnapshot){

    if(documentSnapshot.data() != null){

    
    // doc.data()[""]method is deprcreate use doc.get("") instead
    _url=documentSnapshot.get("imageurls");
    _description=documentSnapshot.get("description");
    _type=documentSnapshot.get("type");

                                        

    }

    



  }











}