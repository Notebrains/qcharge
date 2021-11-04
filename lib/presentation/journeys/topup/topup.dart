import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my2c2psdk/models/my2c2psdk_type.dart';
import 'package:my2c2psdk/my2c2psdk.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/common/extensions/validation.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/presentation/blocs/home/topup_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/wallet_recharge_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/journeys/topup/usage_history.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_if_ic_round.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_img_row.dart';

class TopUp extends StatefulWidget {
  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  //late WalletRechargeCubit walletRechargeCubit;

  AuthenticationLocalDataSourceImpl localData = AuthenticationLocalDataSourceImpl();

  bool isTopUpBtnSelected = false;
  bool isAddMoneyActive = false;

  String userId = '';
  late TextEditingController? _topupAmountController;
  final ValueNotifier<String> _walletBalance = ValueNotifier<String>('0.00');

  @override
  void initState() {
    super.initState();

    //walletRechargeCubit = getItInstance<WalletRechargeCubit>();

    getLocalData();
    _topupAmountController = TextEditingController();
    _topupAmountController!.text = '500.00';

  }

  @override
  void dispose() {
    super.dispose();

    //walletRechargeCubit.close();
    _topupAmountController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      drawer: NavigationDrawer(),
      body: BlocBuilder<TopUpCubit, TopUpState>(
        builder: (BuildContext context, state) {
          if (state is TopUpSuccess) {
            //_walletBalance.value = state.model.response!.wallet!;
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
                                builder: (BuildContext context, String walletValue, Widget? child) {  // widget under builder will rebuild
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
                                              text: convertStrToDoubleStr(walletValue),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
                                          TextSpan(
                                              text: ' THB',
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
                                  txt: 'Online Top Up',
                                  txtColor: AppColor.app_txt_white,
                                  txtSize: 16,
                                  img: 'assets/icons/pngs/crete_account_layer_mob_bank.png',
                                ),
                                onTap: () {
                                  setState(() {
                                    isAddMoneyActive ? isAddMoneyActive = false : isAddMoneyActive = true;
                                  });
                                },
                              ),

                             Visibility(
                                visible: isAddMoneyActive,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 24),
                                    child: Image.asset('assets/images/payment-credit-card.png', width: 120, height: 120,),
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: isAddMoneyActive,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: IfIconRound(
                                    hint: 'Enter top-up amount',
                                    icon: Icons.account_balance_wallet_rounded,
                                    controller: _topupAmountController,
                                    textInputType: TextInputType.number,
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
                                      if (_topupAmountController!.text.isEmpty) {
                                        edgeAlert(context,
                                            title: 'Warning', description: 'Please enter amount', gravity: Gravity.top);
                                      } else if (userId.isNotEmpty) {
                                        openPaymentGateway();
                                      } else {
                                        edgeAlert(context,
                                            title: TranslationConstants.message.t(context),
                                            description: 'Something went wrong! Please try again.',
                                            gravity: Gravity.top);
                                      }
                                    },
                                  ),
                                ),
                              ),

                              /*TxtImgRow(txt: TranslationConstants.creditDebitCard.t(context), txtColor: AppColor.app_txt_white, txtSize: 16,
                                  img: 'assets/icons/pngs/crete_account_layer_mob_bank.png',
                                ),

                                TxtImgRow(txt: TranslationConstants.selectTopUpMethod.t(context), txtColor: AppColor.app_txt_white, txtSize: 16,
                                  img: 'assets/icons/pngs/crete_account_layer_mob_bank.png',
                                ),*/

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
                                        gravity: Gravity.top);
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      : TopUpHistory(
                          response: state.model.response,
                        ),
                ],
              ),
            );
          } else {
            return NoDataFound(
              txt: 'No DATA FOUND',
              onRefresh: () {},
            );
          }
        },
      ),
    );
  }

  void openPaymentGateway() async {
    try {
      final sdk = My2c2pSDK(privateKey: Platform.isAndroid? Strings.androidPrivateKey : Strings.iosPrivateKey);
      sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
      sdk.productionMode = false;
      sdk.merchantId = "764764000001966";
      sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 154145).toString();
      sdk.desc = "product item 1";
      sdk.amount = double.parse(_topupAmountController!.text);
      sdk.currencyCode = "764";
      sdk.pan = "5105105105105100";
      sdk.cardExpireMonth = 12;
      sdk.cardExpireYear = 2025;
      sdk.cardHolderName = "Mr. John";
      sdk.cardPin = "4111111111111111";
      sdk.cardType = CardType.OPEN_LOOP;
      sdk.panCountry = "TH";
      sdk.panBank = 'Kasikom Bank';
      sdk.secretKey = "24ABCC819638916E7DD47D09F2DEA4588FAE70636B085B8DE47A9592C4FD034F";
      //set optional fields
      sdk.securityCode = "2234523";
      sdk.cardHolderEmail = 'Thanpilin@arrow-energy.com';

      final result = await sdk.proceed();
      print('----2c2p payment result: $result');

      Map<String, dynamic> responseJson = json.decode(result!);

      String uniqueTransactionCode = responseJson["uniqueTransactionCode"];

      /*String amount = responseJson["amt"];

      print('----amount: ${responseJson["amt"]}');
      print('----uniqueTransactionCode: ${responseJson["uniqueTransactionCode"]}');
      print('----tranRef: ${responseJson["tranRef"]}');
      print('----approvalCode: ${responseJson["approvalCode"]}');
      print('----refNumber: ${responseJson["refNumber"]}');*/

      if (uniqueTransactionCode.isNotEmpty) {
        BlocProvider.of<WalletRechargeCubit>(context).initiateWalletRecharge(
          userId,
          responseJson["uniqueTransactionCode"],
          _topupAmountController!.text,
        );
      } else {
        edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Payment Failed', gravity: Gravity.top);
      }
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
