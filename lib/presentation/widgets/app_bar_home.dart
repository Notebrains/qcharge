import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';


PreferredSizeWidget appBarHome(BuildContext context) {
  return AppBar(
    title: Image.asset('assets/icons/pngs/account_register_2.png', fit: BoxFit.cover, width: 50),
    centerTitle: true,
    backgroundColor: AppColor.grey,
    elevation: 3,
    leading: Icon(Icons.dehaze_outlined, color: Colors.white,),
    actions: <Widget>[
      Image.asset(
        'assets/icons/pngs/account_Register_4.png',
        fit: BoxFit.contain, width: 20, height: 40,
      ),

      Center(child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 5),
        child: Txt(txt: 'TH', txtColor: Colors.white, txtSize: 14, fontWeight: FontWeight.bold, padding: 0, onTap: (){}),
      )),

    ],
  );
}
