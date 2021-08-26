import 'package:flutter/material.dart';

PreferredSizeWidget appBarIcBack (BuildContext context, String text){
  return AppBar(
    centerTitle: false,
    elevation: 3,
    backgroundColor: Colors.black,
    title: Text(
      text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
    ),
    leading: GestureDetector(
      child: Icon(
        Icons.arrow_back_rounded,
        color: Colors.white,// add custom icons also
      ),
      onTap: (){
        Navigator.pop(context);
      },
    ),
  );
}