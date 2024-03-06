import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackButton extends StatelessWidget{
  Icon icon;
  String name;
  VoidCallback? onPressed;
  StackButton({required this.icon,required this.name,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          icon,
          Text(name,style: TextStyle(fontSize: 15,color: Colors.white60),),
        ],
      )
  );
  }
}