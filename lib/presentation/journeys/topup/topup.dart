import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/data/models/top_up_api_res_model.dart';
import 'package:qcharge_flutter/presentation/blocs/home/wallet_recharge_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/topup/usage_history.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/libraries/month_picker/month_picker_dialog.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/select_drop_list.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_img_row.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_txt_txt_row.dart';

import '../payments/2c2p_payment_gateway.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  late TopUpApiResModel topUpModel;
  AuthenticationLocalDataSourceImpl localData = AuthenticationLocalDataSourceImpl();
  late Future<bool> _future;
  DateTime currentDate = DateTime.now();

  late bool isDataAvailable = false;
  bool isTopUpTabSelected = false;

  bool isTopUpBtnSelected = false;
  bool isAddMoneyActive = false;
  int paymentMethodId = 55;

  String userId = '', dropdownTopUpAmount = '';
  final ValueNotifier<String> _walletBalance = ValueNotifier<String>('0.00');

  OptionItem optionItemSelected = OptionItem(id: '0', title: "Select amount");

  DropListModel amountDropDownList = DropListModel([
    OptionItem(id: '500', title: "500 THB"),
    OptionItem(id: '1000', title: "1,000 THB"),
    OptionItem(id: '2000', title: "2,000 THB"),
    OptionItem(id: '3000', title: "3,000 THB"),
    OptionItem(id: '5000', title: "5,000 THB"),
    OptionItem(id: '10000', title: "10,000 THB"),
  ]);

  @override
  void initState() {
    super.initState();

    getLocalData();

    _future = getApiData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getApiData() async {
    String? userId = await AuthenticationLocalDataSourceImpl().getSessionId();
    try {
      http.Response response = await http.post(
        Uri.parse("https://mridayaitservices.com/demo/qcharge/api/v1/topuphistory") , body: {
          "user_id" : userId,
          "filter_date": "${currentDate.year}-${currentDate.month}"
      },
      );
      //print("${ApiConstants.BASE_URL}notification/1");
      //print("notification: ${response.statusCode}");
      print("topup history: ${response.body}");

      topUpModel = TopUpApiResModel.fromJson(jsonDecode(response.body));

      if (topUpModel.status == 1) {
        isDataAvailable = true;
      }
    } catch (error) {
      print("topuphistory: $error");
    }
    return isDataAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(
        onTap: () {},
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            if (isDataAvailable) {
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
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColor.grey,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: AppColor.border),
                              ),
                              child: Image.asset(
                                'assets/images/member_card.png',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 34),
                                  child: Txt(
                                    txt: TranslationConstants.balance.t(context),
                                    txtColor: Colors.white,
                                    txtSize: 10,
                                    fontWeight: FontWeight.bold,
                                    padding: 0,
                                    onTap: () {},
                                  ),
                                ),
                                ValueListenableBuilder(
                                  builder: (BuildContext context, String walletValue, Widget? child) {
                                    // widget under builder will rebuild
                                    // This builder will only get called when the _walletBalanc
                                    // is updated.
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: DefaultTextStyle.of(context).style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: walletValue,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
                                            TextSpan(
                                                text: TranslationConstants.thb.t(context),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  valueListenable: _walletBalance,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45, right: 40),
                      child: Button(
                        text: isTopUpBtnSelected
                            ? TranslationConstants.usageHistory.t(context)
                            : TranslationConstants.topUpCaps.t(context),
                        bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                        onPressed: () {
                          setState(() {
                            isTopUpBtnSelected ? isTopUpBtnSelected = false : isTopUpBtnSelected = true;
                          });
                        },
                      ),
                    ),
                    isTopUpBtnSelected
                        ? SlideInUp(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 36, left: 20, bottom: 12),
                                  child: Text(
                                    TranslationConstants.selectTopUpMethod.t(context),
                                    style: TextStyle(fontSize: 14, color: Colors.white),
                                  ),
                                ),
                                InkWell(
                                  child: TxtImgRow(
                                    txt: TranslationConstants.creditDebitCard.t(context),
                                    txtColor: AppColor.app_txt_white,
                                    txtSize: 14,
                                    img: 'assets/images/credit2.png',
                                  ),
                                  onTap: () {
                                    setState(() {
                                      paymentMethodId = 0;
                                      isAddMoneyActive ? isAddMoneyActive = false : isAddMoneyActive = true;
                                    });
                                  },
                                ),
                                InkWell(
                                  child: TxtImgRow(
                                    txt: "TrueMoney Wallet",
                                    txtColor: AppColor.app_txt_white,
                                    txtSize: 14,
                                    img: 'assets/images/truewallet.png',
                                  ),
                                  onTap: () {
                                    setState(() {
                                      paymentMethodId = 1;
                                      isAddMoneyActive ? isAddMoneyActive = false : isAddMoneyActive = true;
                                    });
                                  },
                                ),
/*

                        InkWell(
                          child: TxtImgRow(
                            txt: "123 Payment",
                            txtColor: AppColor.app_txt_white,
                            txtSize: 14,
                            img: 'assets/images/123download.png',
                          ),
                          onTap: () {
                            setState(() {
                              paymentMethodId = 1;
                              isAddMoneyActive ? isAddMoneyActive = false : isAddMoneyActive = true;
                            });
                          },
                        ),
*/
                                Visibility(
                                  visible: isAddMoneyActive,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 24),
                                      child: Image.asset(
                                        'assets/images/payment-credit-card.png',
                                        width: 120,
                                        height: 120,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isAddMoneyActive,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 36,
                                      right: 36,
                                    ),
                                    child: SelectDropList(
                                      ic: Icons.account_balance_wallet_outlined,
                                      icColor: AppColor.app_txt_white,
                                      itemSelected: optionItemSelected,
                                      onOptionSelected: (OptionItem optionItem) {
                                        //print('----Selected Amount: ${optionItem.id}');
                                        setState(() {
                                          dropdownTopUpAmount = optionItem.id;
                                          optionItemSelected.title = optionItem.title;
                                        });
                                      },
                                      dropListModel: amountDropDownList,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isAddMoneyActive,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 36, right: 36, bottom: 36),
                                    child: Button(
                                      text: TranslationConstants.continueNotCaps.t(context),
                                      bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                                      onPressed: () {
                                        if (dropdownTopUpAmount.isEmpty) {
                                          edgeAlert(context,
                                              title: TranslationConstants.warning.t(context),
                                              description: TranslationConstants.enterTopUpAmount.t(context),
                                              gravity: Gravity.top);
                                        } else if (userId.isNotEmpty) {
                                          openPaymentGateway(context, paymentMethodId);
                                          //requestPayment();
                                        } else {
                                          edgeAlert(context,
                                              title: TranslationConstants.message.t(context),
                                              description: TranslationConstants.somethingWentWrong.t(context),
                                              gravity: Gravity.top);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                BlocConsumer<WalletRechargeCubit, WalletRechargeState>(
                                  buildWhen: (previous, current) => current is WalletRechargeError,
                                  builder: (context, state) {
                                    if (state is WalletRechargeError)
                                      return Text(
                                        state.message.t(context),
                                        style: TextStyle(color: Colors.black),
                                      );
                                    return const SizedBox.shrink();
                                  },
                                  listenWhen: (previous, current) => current is WalletRechargeSuccess,
                                  listener: (context, state) async {
                                    if (state is WalletRechargeSuccess) {
                                      _walletBalance.value = state.model.wallet.toString();
                                      await localData.saveWalletBalance(state.model.wallet.toString());
                                      edgeAlert(context,
                                          title: TranslationConstants.message.t(context),
                                          description: state.model.message!,
                                          gravity: Gravity.top,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        : SlideInUp(
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
                                      //cubit.initiateTopUp('${date.year}-${date.month}'),

                                      setState(() {
                                        currentDate = date;
                                        _future = getApiData();
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


                                  Expanded(child: buildList(topUpModel)),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else return NoDataFound(
              txt: TranslationConstants.loadingCaps.t(context),
              onRefresh: () {},
            );
          } else return NoDataFound(
            txt: TranslationConstants.loadingCaps.t(context),
            onRefresh: () {},
          );
        },
      ),
    );
  }


  Widget buildList(TopUpApiResModel model) {
    //print('----model.length 1: ${model.response!.topupHistory!.length}');
    //print('----model.length 2: ${model.response!.chargingHistory!.length}');
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

  //credentials are live
  void openPaymentGateway(BuildContext context, int paymentMethodId) async {
    try {
      openProductionPaymentGateway(dropdownTopUpAmount, paymentMethodId, "Wallet Top Up").then((responseJson) => {
            /*
              print('-------respCode: ${responseJson["respCode"]}'),
              print('-------failReason: ${responseJson["failReason"]}'),
              print('-------status: ${responseJson["status"]}'),

              String amount = responseJson["amt"];
              String respCode = responseJson["respCode"],
              print('----amount: ${responseJson["amt"]}');
              print('----uniqueTransactionCode: ${responseJson["uniqueTransactionCode"]}');
              print('----tranRef: ${responseJson["tranRef"]}');
              print('----approvalCode: ${responseJson["approvalCode"]}');
              print('----refNumber: ${responseJson["refNumber"]}');
              */

            if (responseJson["uniqueTransactionCode"].isNotEmpty && responseJson["respCode"] == '00')
              {
                BlocProvider.of<WalletRechargeCubit>(context).initiateWalletRecharge(
                  userId,
                  responseJson["uniqueTransactionCode"],
                  dropdownTopUpAmount,
                ),
              }
            else
              {
                edgeAlert(context,
                    title: TranslationConstants.message.t(context),
                    description: TranslationConstants.paymentFailed.t(context),
                    gravity: Gravity.top),
              }
          });
    } catch (e) {
      print('----Error : $e');
    }
  }

  void getLocalData() async {
    await localData.getSessionId().then((id) => {
          userId = id ?? '',
        });

    await localData.getWalletBalance().then((amount) => {
          _walletBalance.value = amount ?? '00.00 ',
        });
  }
}
