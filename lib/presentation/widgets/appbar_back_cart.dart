import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';

import 'badge_icon.dart';

PreferredSizeWidget appBarIcBackCart (BuildContext context, String text){
  return AppBar(
    centerTitle: false,
    elevation: 3,
    title: Text(
      text, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
    ),
    backgroundColor: Colors.white,
    leading: GestureDetector(
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black87,// add custom icons also
      ),
      onTap: (){
        Navigator.pop(context);
      },
    ),

    actions: [
      BadgeIcon(
        icon: Icon(
          Icons.shopping_cart_rounded,
          size: 25,
        ),
        badgeCount: 5,
        onTap: () {
          //Navigator.of(context).pushNamed(RouteList.my_requisition);
        },
      ),
    ],
  );
}