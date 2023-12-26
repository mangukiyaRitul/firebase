import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase/fluttertost.dart';

import 'Custombotton.dart';
import 'SingupPage.dart';
import 'mainpage.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController Phonecontrollar =  TextEditingController();
  TextEditingController otp =  TextEditingController();
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloding = false;
  bool varify = false;
  String  verifyid = '';

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
                            prefix: Icon(CupertinoIcons.phone),
                            placeholder: 'Enter Phone Number',
                            controller: Phonecontrollar,
                            // clearButtonMode: OverlayVisibilityMode.always,
                            autofocus: false,
                            // enableIMEPersonalizedLearning: ,
                            // enabled: false,
                            //   enableSuggestions: false,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          CupertinoTextFormFieldRow(
                            // autofocus: false,
                            padding: EdgeInsets.only(left: 3, top: 10, right: 6, bottom: 10),
                            prefix: Icon(CupertinoIcons.lock),
                            placeholder: 'OTP',
                            controller: otp,
                            obscureText: true,
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
                  text: varify ? 'Varify':"Send otp",onPressed: (){


                      if(_formkey.currentState!.validate())
                      {
                        if(varify == false)
                          {
                            try{
                              setState(() => isloding = true);
                              _auth.verifyPhoneNumber(
                                phoneNumber: "+91${Phonecontrollar.text.trim()}" ,
                                verificationCompleted: (_){},
                                verificationFailed: (e){
                                  toast.toastmessege("${e.code}");
                                },
                                codeSent: (String verificationId , int? token){
                                  setState(() {
                                    verifyid = verificationId;
                                  });
                                },
                                codeAutoRetrievalTimeout: (e) {
                                  toast.toastmessege('${e}');
                                },).then((value){
                                setState(()=> isloding = false);
                                setState(() {
                                  varify = true;
                                });
                              });
                              setState(() => isloding = false);
                            }catch(e){
                              setState(() => isloding = false);
                              toast.toastmessege("$e");
                            }
                          }else{
                          try{
                            setState(()=> isloding = true);
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                              verificationId: verifyid,
                              smsCode: otp.text.trim(),
                            );
                            _auth.signInWithCredential(credential).then((value) {
                              setState(()=> isloding = false);
                              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Mainpage(),));
                            }).onError((error, stackTrace) {
                              toast.toastmessege('$error');
                            });
                           }catch(e){
                            setState(()=> isloding = false);
                            toast.toastmessege('$e');
                          }
                        }
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
                      Navigator.pushReplacement(context, CupertinoDialogRoute(builder: (context) => Singpage(), context: context));
                    }, child: Text('Sign up')),
                  ],
                ),
                Custombotton(
                    // color: Colors.white60,
                    lodar: false,
                    text: 'Login With Email',onPressed: () {
                  Navigator.pop(context);
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
