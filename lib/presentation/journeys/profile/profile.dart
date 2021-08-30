import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/libraries/liquid_linear_progress_bar/liquid_linear_progress_indicator.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 85),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 24),
                        child: cachedNetImgWithRadius(
                          Strings.imgUrlNotFoundYellowAvatar,
                          110,
                          110,
                          30,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 30,),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: ImgTxtRow(
                            txt: 'Username',
                            txtColor: AppColor.app_txt_white,
                            txtSize: 14,
                            fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_6.png',
                            icColor: AppColor.app_txt_white,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                          color: Colors.white,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: ImgTxtRow(
                            txt: 'Member',
                            txtColor: AppColor.app_txt_white,
                            txtSize: 14,
                            fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_6.png',
                            icColor: AppColor.app_txt_white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Txt(
                  txt: 'Collect Point',
                  txtColor: Colors.white,
                  txtSize: 14,
                  fontWeight: FontWeight.bold,
                  padding: 0,
                  onTap: () {},
                ),
              ),

              //_AnimatedLiquidLinearProgressIndicator(),

              Container(
                width: double.infinity,
                height: 25,
                margin: EdgeInsets.only(bottom: 3),
                child: LiquidLinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: AppColor.grey,
                  valueColor: AlwaysStoppedAnimation(AppColor.border),
                  borderColor: Colors.grey,
                  borderWidth: 1.0,
                  borderRadius: 6.0,
                  //center: Text("Loading..."),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Txt(
                    txt: ' VIP',
                    txtColor: Colors.white,
                    txtSize: 14,
                    fontWeight: FontWeight.bold,
                    padding: 0,
                    onTap: () {},
                  ),

                  Txt(
                    txt: ' VIP1',
                    txtColor: Colors.white,
                    txtSize: 14,
                    fontWeight: FontWeight.bold,
                    padding: 0,
                    onTap: () {},
                  ),
                ],
              ),


              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  initialValue: 'Email',
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  //validator: validator,
                  //onSaved: onSaved,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8, right: 24),
                      child: Image.asset(
                        'assets/icons/pngs/account_Register_7.png',
                        width: 15,
                        height: 15,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  initialValue: 'Phone Number',
                  autocorrect: true,
                  keyboardType: TextInputType.phone,
                  //validator: validator,
                  //onSaved: onSaved,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 11, bottom: 11, right: 28),
                      child: Image.asset(
                        'assets/icons/pngs/account_Register_1.png',
                        width: 15,
                        height: 15,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  initialValue: 'Car Brand',
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  //validator: validator,
                  //onSaved: onSaved,
                  decoration: InputDecoration(
                    hintText: 'Car Brand',
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12, right: 18),
                      child: Image.asset(
                        'assets/icons/pngs/profile_screen_8_car.png',
                        width: 15,
                        height: 15,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  initialValue: 'Car Model',
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  //validator: validator,
                  //onSaved: onSaved,
                  decoration: InputDecoration(
                    hintText: 'Car Model',
                    contentPadding: EdgeInsets.only(top: 15, left: 16),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8, right: 16),
                      child: Image.asset(
                        'assets/icons/pngs/account_Register_11.png',
                        width: 15,
                        height: 15,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 56, top: 34),
                child: Button(
                  text: 'LOGOUT',
                  bgColor: Colors.amber,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                              title: new Text("LOGOUT ?"),
                              content: new Text("Are you sure you want to logout?"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).pushNamed(RouteList.login);
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                ),
                              ],
                            ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedLiquidLinearProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidLinearProgressIndicatorState();
}

class _AnimatedLiquidLinearProgressIndicatorState
    extends State<_AnimatedLiquidLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: Container(
        width: double.infinity,
        height: 75.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: LiquidLinearProgressIndicator(
          value: _animationController.value,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          borderRadius: 12.0,
          center: Text(
            "${percentage.toStringAsFixed(0)}%",
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}