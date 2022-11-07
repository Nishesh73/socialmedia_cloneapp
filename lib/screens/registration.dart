import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/screens/home.dart';
import 'package:provider/provider.dart';

class RegisTration extends StatefulWidget {
  const RegisTration({super.key});

  @override
  State<RegisTration> createState() => _RegisTrationState();
}

class _RegisTrationState extends State<RegisTration> {

  
  @override
  Widget build(BuildContext context) {
    final appprovider=Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor:Colors.amber,

      body: Center(
        child: MaterialButton(onPressed: ()async {
          await appprovider.signInwithGoogle();

          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
 },

        child: Text("sign in with google") ,
        color: Colors.red,
        elevation: 20.0,
        shape: Border.all(width: 5.0,color: Colors.blue),
        hoverColor: Colors.pink,
         
        ),
      )
 );
  }
}