import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/blocs/home/topup_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/topup/top_up_banking.dart';
import 'package:qcharge_flutter/presentation/journeys/topup/usage_history.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_txt_txt_row.dart';

class TopUp extends StatefulWidget {
  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  bool isTopUpBtnSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: BlocBuilder<TopUpCubit, TopUpState>(
        builder: (BuildContext context, state) {
          if (state is TopUpSuccess) {
            //print('---- : ${state.model.response!.name}');
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 5),
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      borderRadius: BorderRadius.circular(5.0),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          //child: cachedNetImgWithRadius(Strings.imgUrlMeeting, 100, 100, 0),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColor.grey,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: AppColor.border),
                            ),

                            child: Image.asset('assets/images/member_card.png',),
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Txt(
                                  txt: TranslationConstants.balance.t(context),
                                  txtColor: Colors.white,
                                  txtSize: 12,
                                  fontWeight: FontWeight.bold,
                                  padding: 0,
                                  onTap: () {},
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Txt(
                                  txt: '0.00',
                                  txtColor: Colors.white,
                                  txtSize: 12,
                                  fontWeight: FontWeight.normal,
                                  padding: 0,
                                  onTap: () {

                                  },
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Txt(
                                  txt: 'BAHT',
                                  txtColor: Colors.white,
                                  txtSize: 12,
                                  fontWeight: FontWeight.bold,
                                  padding: 0,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 45, right: 40),
                    child: Button(text: isTopUpBtnSelected?
                    TranslationConstants.usageHistory.t(context) :
                    TranslationConstants.topUpCaps.t(context),
                      bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                      onPressed: () {
                        setState(() {
                          isTopUpBtnSelected? isTopUpBtnSelected = false: isTopUpBtnSelected = true;
                        });
                      },
                    ),
                  ),

                  isTopUpBtnSelected? TopUpBanking() : TopUpHistory(response: state.model.response,),
                ],
              ),
            );
          } else {
            return NoDataFound(txt: 'No Data Found', onRefresh: (){
            },);
          }
        },
      ),
    );
  }

}
