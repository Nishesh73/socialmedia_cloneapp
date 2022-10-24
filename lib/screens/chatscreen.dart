

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("chat screen"),),

      body: Row(children: [

        Expanded(child: TextFormField()),
        IconButton(onPressed: (){}, icon:Icon(Icons.send)),



      ],),



    );
  }
}