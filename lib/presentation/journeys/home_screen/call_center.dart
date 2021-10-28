import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubscriptionState();
  }
}

class _SubscriptionState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColor.grey,
                //margin: const EdgeInsets.fromLTRB(12, 42, 12, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: Sizes.dimen_60.w),
                        child: Image.asset(
                          'assets/images/communicate.png',
                          width: Sizes.dimen_110.w,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: Sizes.dimen_20.h),
                      child: Text(
                          TranslationConstants.getInTouch.t(context),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.dimen_24.w, color: Colors.white, letterSpacing: 3),
                      ),
                    ),
                    Text(
                      TranslationConstants.withinReachTxt.t(context),
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: Sizes.dimen_14.w, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: Sizes.dimen_150.h,
            backgroundColor: AppColor.app_bg,
            leading: IconButton(
              icon: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              tooltip: 'Back to previous page',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(_buildList(context)),
          )
        ],
      ),
    );
  }

  _launchCaller() async {
    const url = "tel:1234567890";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'Arrow Energy'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmailApp() async {
    const url = 'mailto:sejpalbhargav67@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Widget> _buildList(BuildContext context) {
    List<Widget> listItems = [];
    listItems.add(
      Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/pngs/profile_screen_7_mobile.png',
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                    child: Text(
                      TranslationConstants.mobNo.t(context),
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      maxLines: 4,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 5, bottom: 8),
                      child: Text(
                        '094-445-6447',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ),

                    Icon(Icons.arrow_right, size: 22, color: Colors.white70,),
                  ],
                ),

                onTap: (){
                  _launchCaller();
                },
              ),

              Divider(
                color: Colors.white70,
              ),


              Row(
                children: [
                  Image.asset(
                    'assets/icons/pngs/account_Register_7.png',
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                    child: Text(
                      TranslationConstants.email.t(context),
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),

              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 5, bottom: 8),
                      child: Text(
                        'qcharge.contact@gmail.com',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ),

                    Icon(Icons.arrow_right, size: 22, color: Colors.white70,),
                  ],
                ),

                onTap: (){
                  _launchEmailApp();
                },
              ),

              Divider(
                color: Colors.white70,
              ),


              Row(
                children: [
                  Icon(Icons.web_outlined, color: Colors.white70),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                    child: Text(
                      'Website',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),

              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 5, bottom: 8),
                      child: Text(
                        'https://www.arrow-energy.com/',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ),

                    Icon(Icons.arrow_right, size: 22, color: Colors.white70,),
                  ],
                ),

                onTap: (){
                  _launchInBrowser('https://www.arrow-energy.com/');
                },
              ),

              Divider(
                color: Colors.white70,
              ),


              Row(
                children: [
                  Image.asset(
                    'assets/icons/pngs/create_account_map.png',
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                    child: Text(
                      TranslationConstants.address.t(context),
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      maxLines: 4,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              InkWell(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 5, bottom: 8),
                      child: Text(
                        'Arrow Energy Co., Ltd, 87/114-116 Soi\nSukhumvit 63 (Ekkamai), Khlong Tan\nNuea, Wattana, Bangkok 10110',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ),

                    //Icon(Icons.arrow_right, size: 22, color: Colors.white,),
                  ],
                ),

                onTap: (){

                },
              ),

            ],
          )),
    );

    return listItems;
  }
}
