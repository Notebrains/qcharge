import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

PreferredSizeWidget appBarHome(BuildContext context) {
  return AppBar(
    toolbarHeight: Sizes.dimen_26.h,
    title: Image.asset('assets/icons/pngs/q_charge_logo_1.png', fit: BoxFit.cover, width: 30),
    centerTitle: true,
    backgroundColor: AppColor.grey,
    elevation: 3,
    actions: <Widget>[
      Image.asset(
        'assets/icons/pngs/account_Register_4.png',
        fit: BoxFit.contain,
        width: 18,
        height: 18,
      ),

      Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 12,),
          child: PopupMenuButton<String>(
            icon: Center(
              child: Txt(txt: 'TH', txtColor: Colors.white, txtSize: 14, fontWeight: FontWeight.bold, padding: 0, onTap: () {}),
            ),
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return {'TH', 'ENG'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: ListTile(
                    leading: Image.asset(
                      choice == 'TH' ? 'assets/icons/pngs/account_register_3.png' : 'assets/icons/pngs/account_Register_4.png',
                      fit: BoxFit.contain,
                      width: 20,
                      height: 40,
                    ),

                    title: Text(
                      choice,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    ],
  );
}
