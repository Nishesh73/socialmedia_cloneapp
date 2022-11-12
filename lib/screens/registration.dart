import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisTration extends StatefulWidget {
  const RegisTration({super.key});

  @override
  State<RegisTration> createState() => _RegisTrationState();
}

class _RegisTrationState extends State<RegisTration> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final appprovider = Provider.of<AppProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white70.withOpacity(0.2),
        body: Center(
          child:isLoading?CircularProgressIndicator(): Container(
            height: 50.0,
            child: SignInButton(
              Buttons.GoogleDark,
              onPressed: () async {

                setState(() {
                  isLoading=true;
                  
                });
                 
                await appprovider.signInwithGoogle();
                setState(() {
                  isLoading=false;
                });
               
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyHome()),
                    
                    
                    );
              },
              
              
            ),
          ),
        ));
  }
}
