import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_txt_switch.dart';

class Setting extends StatefulWidget{
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isPrivateOn = true;
  bool isPublicOn = true;
  bool isAcOn = true;
  bool isDcOn = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 3,
        backgroundColor: Colors.black,
        title: Text(
          'Filter', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,// add custom icons also
          ),
          onTap: (){
            Navigator.of(context).pop(FilterModel(isPrivateOn: isPrivateOn, isPublicOn: isPublicOn, isAcOn: isAcOn, isDcOn: isDcOn));
          },
        ),
      ),
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

            IcTxtSwitch(txt: 'Private', img: 'assets/icons/pngs/create_account_layer_2.png', isSwitchOn: isPrivateOn, isVisible: true,
              onSwitchChange: (bool value) {
                setState(() {
                  isPrivateOn = value;
                });
              },),

            IcTxtSwitch(txt: 'Public', img: 'assets/icons/pngs/filter_0016_Layer-3.png', isSwitchOn: isPublicOn, isVisible: true,
              onSwitchChange: (bool value) {
                setState(() {
                  isPublicOn = value;
                });
              },),

            //IcTxtSwitch(txt: 'Maintenance', img: 'assets/icons/pngs/filter_0014_Layer-4.png', isSwitchOn: true, isVisible: true,),
            //IcTxtSwitch(txt: 'Coming soon', img: 'assets/icons/pngs/filter_0013_Layer-5.png', isSwitchOn: true, isVisible: false,),

            Container(
              width: double.maxFinite,
              color: AppColor.grey,
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 8, top: 12),
              child: Text('Ev Stations Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white),),
            ),

            IcTxtSwitch(txt: 'AC', img: 'assets/icons/pngs/filter_0011_AC.png', isSwitchOn: isAcOn, isVisible: true,
              onSwitchChange: (bool value) {
                setState(() {
                  isAcOn = value;
                });
              },),
            IcTxtSwitch(txt: 'DC', img: 'assets/icons/pngs/filter_dc.png', isSwitchOn: isDcOn, isVisible: false,
              onSwitchChange: (bool value) {
                setState(() {
                  isDcOn = value;
                });
              },),
/*
            Container(
              width: double.maxFinite,
              color: AppColor.grey,
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 8, top: 12),
              child: Text('Ev Stations Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white),),
            ),

            IcTxtSwitch(txt: 'Type 1', img: 'assets/icons/pngs/filter_type_1.png', isSwitchOn: true, isVisible: true,
              onSwitchChange: (bool value) {
                setState(() {
                  isPrivateOn = value;
                });
              },),
            IcTxtSwitch(txt: 'Type 2', img: 'assets/icons/pngs/filter_type_2.png', isSwitchOn: true, isVisible: true,
              onSwitchChange: (bool value) {
                setState(() {
                  isPrivateOn = value;
                });
              },),



            //IcTxtSwitch(txt: 'CCS2', img: 'assets/icons/pngs/filter_ccs2.png', isSwitchOn: true, isVisible: false,),


            Container(
              width: double.maxFinite,
              color: AppColor.grey,
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 8, top: 12),
              child: Text('Ev Stations Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.white),),
            ),

            IcTxtSwitch(txt: 'Walk In Mode', img: 'assets/icons/pngs/filter_walk_in_mode_2.png', isSwitchOn: true, isVisible: true,),
            IcTxtSwitch(txt: 'Reserve Mode', img: 'assets/icons/pngs/filter_reserve_mode_2.png', isSwitchOn: true, isVisible: false,),
*/
          ],
        ),
      ),
    );
  }
}


class FilterModel {
  bool isPrivateOn;
  bool isPublicOn;
  bool isAcOn;
  bool isDcOn;

  FilterModel({required this.isPrivateOn, required this.isPublicOn, required this.isAcOn, required this.isDcOn});
}
