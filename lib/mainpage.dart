import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Custombotton.dart';
import 'package:firebase/MyHomePage.dart';
import 'package:firebase/fluttertost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Mainpage extends StatefulWidget {
   Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
final auth = FirebaseAuth.instance;

CollectionReference user = FirebaseFirestore.instance.collection("user");

FirebaseAuth _auth = FirebaseAuth.instance;
User? userid = FirebaseAuth.instance.currentUser;


bool useraddloding =false;

    // data stor
    Future<void>? adduser(){
      setState(() => useraddloding = true);
      final currentuser =  _auth.currentUser;
     try{
       return   user.doc("${userid!.uid}").set(
           {
             "Name":"${currentuser!.email}",
             "Tocan":" ${currentuser.refreshToken}",
             "Uid":"${userid!.uid}",
           }
       ).then((value) {
         setState(() => useraddloding = false );
         toast.toastmessege("User add");
       });
     }
     on FirebaseException catch(e){
       toast.toastmessege("${e.code}");
       return null;
     }
     catch(e){
       toast.toastmessege("${e}");
       return null;
     }
      }

    // notification
   FirebaseMessaging messaging = FirebaseMessaging.instance;

    Future<void> requstNotificationPermission() async {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        criticalAlert: true,
        carPlay: true,
        provisional: true,
        sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized)
        {
          print("user granted permission");
        }else if(settings.authorizationStatus == AuthorizationStatus.authorized)
          {
            print("user granted provision parmission ");
          }else{
        print("user denied permission ");
      }
    }

 

@override
  void initState() {

    super.initState();
  }

bool loding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () async {
             try{
               setState(()=> loding = true );
               auth.signOut().then((value) {
                 setState(()=> loding = false );
               Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MyHomePage(),));
               }
             );
              await GoogleSignIn().signOut();

             }on FirebaseAuthException catch(e){
               setState(()=> loding = false );
               toast.toastmessege("${e.code}");
             }
             catch(e){
               toast.toastmessege("${e}");
               setState(()=> loding = false );
             }
            // auth.signOut().then((value) {
            //   Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MyHomePage(),));
            // });
          }, icon: Icon(Icons.logout_rounded))
        ],
        // leading: IconButton(onPressed: (){
        //   Navigator.pop(context);
        // }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Center(
            child: Custombotton(
              lodar: useraddloding,
              text: "Add User",
              onPressed: adduser,
              // lodar: ,
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("user")
                .where("Uid",isEqualTo: "${userid?.uid}")
                .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot>  snapshot) {
              if(snapshot.hasError)
                {
                  return Text("Somthing went wrong!");
                }
              else if (snapshot.connectionState == ConnectionState.waiting)
                {
                  return Center(
                    child: CupertinoActivityIndicator(color: Colors.deepPurple),
                  );
                }
              else if (snapshot.data!.docs.isEmpty)
                {
                  // print("${snapshot.data!.docs}");
                  return Text("No Data Found!");
                }
              else if(snapshot.data != null)
                {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Text("Name:${snapshot.data!.docs[index]["Name"]}"),
                              // Text(data),
                              // Text(data),
                              // Text(data),
                            ],
                          ),
                        );
                      }, );
                }
              else
                {
                  return Container();
                }
              }, )
        ],
      )
    );
  }
}
