import 'package:firebase/fluttertost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Custombotton.dart';
import 'mainpage.dart';

class Singpage extends StatefulWidget {
  const Singpage({super.key});

  @override
  State<Singpage> createState() => _SingpageState();
}

class _SingpageState extends State<Singpage> {
  TextEditingController Emailcnrollar =  TextEditingController();
  TextEditingController Passwordcnrollar =  TextEditingController();
  final _formkey =  GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:20 ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoTextField.borderless(
                            padding: EdgeInsets.only(left: 15, top: 10, right: 6, bottom: 10),
                            prefix: Icon(CupertinoIcons.person_alt),
                            placeholder: 'Enter Email',
                            controller: Emailcnrollar,
                            // clearButtonMode: OverlayVisibilityMode.always,
                            autofocus: false,
                            // enableIMEPersonalizedLearning: ,
                            // enabled: false,
                            //   enableSuggestions: false,
                            autofillHints: const [
                              // "Ritul"
                              AutofillHints.name,
                              AutofillHints.email,
                              AutofillHints.addressCityAndState,
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          CupertinoTextField.borderless(
                            obscureText: true,
                            autofocus: false,
                            padding: EdgeInsets.only(left: 15, top: 10, right: 6, bottom: 10),
                            prefix: Icon(CupertinoIcons.lock),
                            placeholder: 'Enter Password',
                            controller: Passwordcnrollar,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Custombotton(
                  lodar: isloding,
                  text: 'Sing up',onPressed: (){
                  setState(() => isloding = true);
                  if(_formkey.currentState!.validate())
                    {
                      _auth.createUserWithEmailAndPassword(
                          email: Emailcnrollar.text.trim(),
                          password: Passwordcnrollar.text.trim(),
                      ).then((value) {
                        setState(() => isloding = false);
                      }).onError((error, stackTrace) {
                      toast.toastmessege("$error");
                      Future.delayed(Duration(seconds: 2));
                      setState(() => isloding = false);
                      });
                    }
                }, ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aleady have an account?"),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('Login'))
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
