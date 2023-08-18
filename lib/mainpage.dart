import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
   Mainpage({super.key});
final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value) {
              Navigator.pop(context);
            });
          }, icon: Icon(Icons.logout_rounded))
        ],
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
    );
  }
}
