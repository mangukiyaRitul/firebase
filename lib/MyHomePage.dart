import 'package:firebase/phonevalifiction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase/fluttertost.dart';

import 'Custombotton.dart';
import 'SingupPage.dart';
import 'mainpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController Emailcnrollar =  TextEditingController();
  TextEditingController Passwordcnrollar =  TextEditingController();
  final _formkey = GlobalKey<FormState>();
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
                              AutofillHints.name,
                              AutofillHints.email,
                              AutofillHints.addressCityAndState,
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          CupertinoTextFormFieldRow(
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
                  lodar: false,
                  text: 'Login',onPressed: (){
                    if(_formkey.currentState!.validate())
                      {
                        setState(() => isloding = true);
                        _auth.signInWithEmailAndPassword(
                            email: Emailcnrollar.text.trim(),
                            password: Passwordcnrollar.text.trim()).then((value) {
                              // print('$value');
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => Mainpage() ,));
                              setState(() => isloding = false);
                        }).onError((error, stackTrace){
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
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: () {
                      Navigator.push(context, CupertinoDialogRoute(builder: (context) => Singpage(), context: context));
                    }, child: Text('Sign up')),
                  ],
                ),
                // Custombotton(
                //   lodar: false,
                //   text: 'Gaust',onPressed: (){
                //   if(_formkey.currentState!.validate())
                //   {
                //     setState(() => isloding = true);
                //     _auth.signInWithEmailAndPassword(
                //         email: Emailcnrollar.text.trim(),
                //         password: Passwordcnrollar.text.trim()).then((value) {
                //       // print('$value');
                //       Navigator.push(context, CupertinoPageRoute(builder: (context) => Mainpage() ,));
                //       setState(() => isloding = false);
                //     }).onError((error, stackTrace){
                //       toast.toastmessege("$error");
                //       Future.delayed(Duration(seconds: 2));
                //       setState(() => isloding = false);
                //     });
                //   }
                // }, ),
                Custombotton(
                 color: Colors.white60,
                  lodar: false,
                  text: 'Login With Phone',onPressed: () {
                   Navigator.push(context, CupertinoPageRoute(builder: (context) => Phone(),));
                }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
