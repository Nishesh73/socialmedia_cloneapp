import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
String? val;

 
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        
      ),
        body:Card(
          elevation: 20.0,

          child: Row(

            children: [
              Expanded(
              
               
                child: TextField(
                  decoration: InputDecoration(
                    
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: ((value) {

                    setState(() {
                        val=value;
                    });
                  


                    
                  }),
                  


                )),

             

            ],
          ),


        )


      
    );
  }

}