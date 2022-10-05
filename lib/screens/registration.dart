
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
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

      body: Center(
        child: MaterialButton(onPressed: (){
          appprovider.signInwithGoogle();


        },

        child: Text("sign in with google") ,
        color: Colors.red,
        
        
        
        
        ),
      )




    );
  }
}