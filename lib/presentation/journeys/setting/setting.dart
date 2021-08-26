import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_txt_switch.dart';
import 'package:qcharge_flutter/presentation/widgets/switcher_btn.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

class Setting extends StatefulWidget{
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isNotificationSwitchOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Filter'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.maxFinite,
                color: AppColor.grey,
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(bottom: 8, top: 8),
                child: Text('Ev Stations Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white),),
            ),

            IcTxtSwitch(txt: 'Private', img: 'assets/icons/pngs/create_account_layer_2.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'Public', img: 'assets/icons/pngs/filter_0016_Layer-3.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'Maintenance', img: 'assets/icons/pngs/filter_0014_Layer-4.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'Coming soon', img: 'assets/icons/pngs/filter_0013_Layer-5.png', isSwitchOn: true, isVisible: false,),

            Container(
              width: double.maxFinite,
              color: AppColor.grey,
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 8, top: 12),
              child: Text('Ev Stations Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white),),
            ),

            IcTxtSwitch(txt: 'AC', img: 'assets/icons/pngs/filter_0011_AC.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'DC', img: 'assets/icons/pngs/filter_dc.png', isSwitchOn: true, isVisible: false,),

            Container(
              width: double.maxFinite,
              color: AppColor.grey,
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 8, top: 12),
              child: Text('Ev Stations Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white),),
            ),

            IcTxtSwitch(txt: 'Type 1', img: 'assets/icons/pngs/filter_type_1.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'Type 2', img: 'assets/icons/pngs/filter_type_2.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'CCS2', img: 'assets/icons/pngs/filter_ccs2.png', isSwitchOn: true, isVisible: false,),

            Container(
              width: double.maxFinite,
              color: AppColor.grey,
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 8, top: 12),
              child: Text('Ev Stations Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white),),
            ),

            IcTxtSwitch(txt: 'Walk In Mode', img: 'assets/icons/pngs/filter_walk_in_mode_2.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'Reserve Mode', img: 'assets/icons/pngs/filter_reserve_mode_2.png', isSwitchOn: true, isVisible: false,),
          ],
        ),
      ),
    );
  }
}