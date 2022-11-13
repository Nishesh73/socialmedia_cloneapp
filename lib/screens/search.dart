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
String? query;



  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Card(
          elevation: 10.0,
          
              child: 
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Expanded(
                    
                     
                      child: TextField(
                        decoration: InputDecoration(
                          
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: ((value) {

                          
                             
                        


                          
                        }),
                        


                      )),
                  ),

                 

                
              ),


 
        ),

        body: StreamBuilder(stream: query!=null && query!=""?FirebaseFirestore.instance.collection("users").where("name",isEqualTo:query ).snapshots():
        FirebaseFirestore.instance.collection("users").snapshots(),

          
          builder:(context, snapshots){

            return snapshots.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator()):

            ListView.builder
            (itemCount: snapshots.data!.docs.length,
              itemBuilder: (context,index){
                var document=snapshots.data!.docs[index];

                return Container(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(document["name"]),

                      ),
                     //continer
                    ],
                  ),
                );


              });

            
          } ),

        
      );
      

      
    
  }

}