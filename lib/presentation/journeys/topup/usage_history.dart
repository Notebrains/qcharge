import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/topup_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/libraries/month_picker/month_picker_dialog.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_txt_txt_row.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';


class TopUpHistory extends StatefulWidget {

  const TopUpHistory({Key? key}) : super(key: key);

  @override
  _TopUpHistoryState createState() => _TopUpHistoryState();
}

class _TopUpHistoryState extends State<TopUpHistory> {
  DateTime currentDate = DateTime.now();
  bool isTopUpTabSelected = false;
  TopUpCubit cubit = getItInstance<TopUpCubit>();


  @override
  void initState() {
    super.initState();

    getTopUpData();
  }

  @override
  void dispose() {
    super.dispose();

    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<TopUpCubit>(
      create: (context) => cubit,
      child: BlocBuilder<TopUpCubit, TopUpState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is TopUpSuccess) {
              return SlideInUp(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 25),
                          child: Txt(txt: TranslationConstants.usageHistory.t(context), txtColor: Colors.white, txtSize: 16,
                            fontWeight: FontWeight.bold, padding: 0, onTap: (){},
                          ),
                        ),

                        InkWell(
                          child: Container(
                              height: 60,
                              width: 130,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.only(top: 12, bottom: 25),
                              child: Text(formatDateInMonthYear(currentDate),
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),)
                          ),

                          onTap: () async {
                            String? userId =  await AuthenticationLocalDataSourceImpl().getSessionId();
                            showMonthPicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 1, DateTime.now().month),
                                lastDate: DateTime(DateTime.now().year + 1, 9),
                                initialDate: DateTime(DateTime.now().year, DateTime.now().month)).then((date) => {
                              if (userId != null && date != null) {
                                //print('------${date.year}-${date.month}'),
                                cubit.initiateTopUp('${date.year}-${date.month}'),

                                setState(() {
                                  currentDate = date;
                                }),
                              } else {
                                edgeAlert(context,
                                    title: TranslationConstants.message.t(context),
                                    description: 'Date not found. Please try again.',
                                    gravity: Gravity.top),
                              }
                            });

                          },
                        ),
                      ],
                    ),

                    Container(
                        height: Sizes.dimen_250.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isTopUpTabSelected? AppColor.text : Colors.grey.shade700,
                                    ),
                                    margin: const EdgeInsets.only(bottom: 25),
                                    child: Txt(txt: TranslationConstants.topUpHistory.t(context), txtColor: Colors.white, txtSize: 16,
                                      fontWeight: FontWeight.bold, padding: 0, onTap: (){
                                        setState(() {
                                          isTopUpTabSelected = true;
                                        });
                                      },
                                    ),
                                  ),
                                ),

                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isTopUpTabSelected? Colors.grey.shade700: AppColor.text,
                                    ),
                                    margin: const EdgeInsets.only(bottom: 25),
                                    child: Txt(txt: TranslationConstants.chargingHistory.t(context), txtColor: Colors.white, txtSize: 16,
                                      fontWeight: FontWeight.bold, padding: 0, onTap: (){
                                        setState(() {
                                          isTopUpTabSelected = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TxtTxtTxtRow(
                                text1: isTopUpTabSelected? "${TranslationConstants.date.t(context)}:" : TranslationConstants.dateTime.t(context),
                                text2: isTopUpTabSelected? TranslationConstants.time.t(context) : TranslationConstants.duration.t(context),
                                text3: TranslationConstants.amount.t(context),
                                text4: TranslationConstants.unit.t(context),
                                size: 13,
                                fontWeight: FontWeight.bold,
                                isTopUpTabSelected: isTopUpTabSelected,
                              ),
                            ),


                            Expanded(child: buildList(state.model)),
                          ],
                        )
                    ),
                  ],
                ),
              );
            } else return NoDataFound(txt: 'No Data Found', onRefresh: (){},);
          }),
    );
  }


  Widget buildList(TopUpApiResModel model) {
    print('----model.length 1: ${model.response!.topupHistory!.length}');
    print('----model.length 2: ${model.response!.chargingHistory!.length}');
    if (model.status == 1) {
      return ListView.builder(
        itemCount: isTopUpTabSelected? model.response!.topupHistory!.length: model.response!.chargingHistory!.length,
        itemBuilder: (context, position) {
          return FadeIn(
            child: TxtTxtTxtRow(
              text1: isTopUpTabSelected? model.response!.topupHistory![position].date! : model.response!.chargingHistory![position].date!,
              text2: isTopUpTabSelected? model.response!.topupHistory![position].time! : model.response!.chargingHistory![position].time!,
              text3: isTopUpTabSelected? model.response!.topupHistory![position].amount! + TranslationConstants.thb.t(context):
              model.response!.chargingHistory![position].price!  + TranslationConstants.thb.t(context),
              text4: !isTopUpTabSelected? model.response!.chargingHistory![position].consumeCharge! + ' kWh': '',
              size: 11,
              fontWeight: FontWeight.normal,
              isTopUpTabSelected: isTopUpTabSelected,
            ),
          );
        },
      );
    } else return Container(
        child: Text("No data found"),
    );
  }

  void getTopUpData() async {
    await AuthenticationLocalDataSourceImpl().getSessionId().then((id) => {
      print('----id, date : $id, ${DateTime.now().year}-${DateTime.now().month}'),
      cubit.initiateTopUp("${DateTime.now().year}-${DateTime.now().month}"),
    });
  }
}
