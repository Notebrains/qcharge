import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/topup_cubit.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_txt_txt_row.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';


class TopUpHistory extends StatefulWidget {
  final Response? response;

  const TopUpHistory({Key? key, required this.response}) : super(key: key);

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

    // cubit = getItInstance<TopUpCubit>();
    // BlocProvider.of<TopUpCubit>(context).initiateTopUp('2', '2021-09');
  }

  @override
  void dispose() {
    super.dispose();

    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: widget.response != null ?  Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 25),
                child: Txt(txt: TranslationConstants.usageHistory.t(context), txtColor: Colors.white, txtSize: 14,
                  fontWeight: FontWeight.bold, padding: 0, onTap: (){},
                ),
              ),

              Container(
                height: 60,
                width: 130,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(top: 12, bottom: 25),
                child: Txt(txt: '${currentDate.month}, ${currentDate.year}', txtColor: Colors.white, txtSize: 14,
                  fontWeight: FontWeight.bold, padding: 0, onTap: () async{
                    _selectDate(context);
                    await AuthenticationLocalDataSourceImpl().getSessionId().then((userId) => {
                      if (userId != null) {
                        cubit.initiateTopUp(userId, '${currentDate.year}-${currentDate.month}'),
                      }
                    });

                  },
                ),
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
              margin: const EdgeInsets.only(left: 24, right: 24),
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
                            color: isTopUpTabSelected? Colors.grey.shade700 : AppColor.grey,
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
                            color: isTopUpTabSelected? AppColor.grey : Colors.grey.shade700,
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

                  Visibility(
                    visible: isTopUpTabSelected? widget.response!.topupHistory!.length>0? true: false
                        : widget.response!.chargingHistory!.length> 0? true: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TxtTxtTxtRow(
                        text1: '   ${TranslationConstants.date.t(context)}',
                        text2: '         ${TranslationConstants.time.t(context)}',
                        text3: TranslationConstants.amount.t(context),
                        size: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),


                  Expanded(
                    child: ListView.builder(
                      itemCount: isTopUpTabSelected? widget.response!.topupHistory!.length: widget.response!.chargingHistory!.length,
                      itemBuilder: (context, position) {
                        return FadeIn(
                          child: TxtTxtTxtRow(
                            text1: widget.response!.topupHistory![position].date!,
                            text2: widget.response!.topupHistory![position].time!,
                            text3: isTopUpTabSelected? widget.response!.topupHistory![position].amount! :
                            widget.response!.chargingHistory![position].price!,
                            size: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
          ),
        ],
      ) : NoDataFound(txt: TranslationConstants.loadingCaps.t(context), onRefresh: (){}),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }
}
