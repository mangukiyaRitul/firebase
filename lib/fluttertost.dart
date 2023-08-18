import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class toast{

  static void toastmessege( String messege ){
    Fluttertoast.showToast(
        msg: "$messege",
      textColor: Colors.white,
      backgroundColor: Colors.deepPurple
    );
  }
}