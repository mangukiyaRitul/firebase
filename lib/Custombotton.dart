
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custombotton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  final bool? lodar;
   Custombotton({
    super.key,
    required this.text,
    this.onPressed,
     this.lodar = false,
      this.color = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor : color,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(8),),
            minimumSize: Size(250, 45),
            elevation: 3,
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 40.0, vertical: 20.0),
        ),
        onPressed: onPressed,
        child: lodar!  ? CupertinoActivityIndicator(color: Colors.white,) :Text("$text",style: TextStyle(color: Colors.white,fontSize: 20),));
  }
}
