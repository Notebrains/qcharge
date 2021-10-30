import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my2c2psdk/models/my2c2psdk_type.dart';
import 'package:my2c2psdk/my2c2psdk.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/bill_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/bill_pay_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';


class Billing extends StatefulWidget {
  const Billing({Key? key}) : super(key: key);

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  late BillCubit billCubit;
  late BillPaymentCubit billPayCubit;

  String _userId = '';
  String walletBalance = '0.00';
  String totalBill = '0.00';

  @override
  void initState() {
    super.initState();
    billCubit = getItInstance<BillCubit>();
    billPayCubit = getItInstance<BillPaymentCubit>();

    getLocalData();
  }

  @override
  void dispose() {
    super.dispose();

    billCubit.close();
    billPayCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, TranslationConstants.yourBilling.t(context)),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: billCubit),
          BlocProvider.value(value: billPayCubit),
        ],
        child: BlocBuilder<BillCubit, BillState>(builder: (context, state) {
          if (state is BillSuccess && state.model.status == 1) {
            totalBill = state.model.response!.totalBilling.toString();

            return Column(
              children: [
                Container(
                  height: 160,
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    border: Border.all(color: AppColor.border, width: 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: InkWell(
                    onTap: (){

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'total spend',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14, ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: convertStrToDoubleStr(state.model.response!.totalBilling.toString()),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34, color: Colors.white)),
                                TextSpan(text: ' THB',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 6),
                          child: RichText(
                            text: TextSpan(
                              text: 'from  ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: state.model.response!.startDate!,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),

                                TextSpan(text: '  to  ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),

                                TextSpan(text: state.model.response!.endDate!,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12,),
                  padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    border: Border.all(color: AppColor.border, width: 0.3),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Date',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Duration',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Unit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.2,
                              height: 1.3,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      border: Border.all(color: AppColor.border, width: 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: ListView.builder(
                      itemCount: state.model.response!.history!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].date!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].startTime!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].duration!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  state.model.response!.history![index].unit!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  '${convertStrToDoubleStr(state.model.response!.history![index].price!)} THB',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.2,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                BlocConsumer<BillPaymentCubit, BillPaymentState>(
                  buildWhen: (previous, current) => current is BillPaymentError,
                  builder: (context, state) {
                    if (state is BillPaymentError)
                      return Text(
                        'Could not fetch data',
                        style: TextStyle(color: Colors.black),
                      );
                    return const SizedBox.shrink();
                  },
                  listenWhen: (previous, current) => current is BillPaymentSuccess,
                  listener: (context, state) {
                    if (state is BillPaymentSuccess) {
                      edgeAlert(context, title: TranslationConstants.message.t(context), description: state.model.message!, gravity: Gravity.top);
                      Navigator.of(context).pushNamedAndRemoveUntil(RouteList.home_screen,(route) => false,);
                    }
                  },
                ),
              ],
            );
          } else {
            return NoDataFound(txt: TranslationConstants.loadingCaps.t(context), onRefresh: (){
            },);
          }
        }),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton.extended(
          backgroundColor: AppColor.alert_color,
          label: Text(TranslationConstants.payBill.t(context), style: TextStyle(color: AppColor.app_txt_white, fontWeight: FontWeight.bold,),),
          icon: Icon(Icons.payment, color: AppColor.app_txt_white,),
          onPressed: () {
            Alert(
              context: context,
              title: TranslationConstants.paymentMethod.t(context),
              desc: "${TranslationConstants.message.t(context)}\n\n ${TranslationConstants.walletBalance.t(context)}: ${convertStrToDoubleStr(walletBalance)} thb",
              image: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/images/payment-credit-card.png", width: 170, height: 170,),
              ),
              buttons: [
                DialogButton(
                  color: Colors.amber,
                  onPressed: () {
                    if (totalBill.isNotEmpty && totalBill != '0.00')billPayCubit.initiateBillPayment(_userId, (Random().nextInt(912319541) + 12319541).toString() , totalBill, 'Wallet');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    TranslationConstants.wallet.t(context),
                    style: TextStyle(
                        color: Colors.black, fontSize: 14),
                  ),
                ),
                DialogButton(
                  color: Colors.amber,
                  onPressed: () {
                    if (totalBill.isNotEmpty && totalBill != '0.00')openPaymentGateway();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    TranslationConstants.payOnline.t(context),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                )
              ],
            ).show();
          },
        ),
      ),
    );
  }




  void openPaymentGateway() async {
    try {
      final sdk = My2c2pSDK(
        privateKey: Platform.isAndroid? Strings.androidPrivateKey : Strings.iosPrivateKey);
      sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
      sdk.productionMode = false;
      sdk.merchantId = "764764000001966";
      //sdk.uniqueTransactionCode = "1015091923644";
      sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 12319541).toString();
      sdk.desc = "product item 1";
      sdk.amount = double.parse(totalBill);
      sdk.currencyCode = "764";
      sdk.pan = "5105105105105100";
      sdk.cardExpireMonth = 12;
      sdk.cardExpireYear = 2025;
      sdk.cardHolderName = "Mr. John";
      sdk.cardPin = "4111111111111111";
      sdk.cardType = CardType.OPEN_LOOP;
      sdk.panCountry = "THAILAND";
      sdk.panBank = 'Kasikom Bank';
      sdk.secretKey = "24ABCC819638916E7DD47D09F2DEA4588FAE70636B085B8DE47A9592C4FD034F";
      //set optional fields
      sdk.securityCode = "2234523";
      sdk.cardHolderEmail = 'Thanpilin@arrow-energy.com';

      final result = await sdk.proceed();
      print('----2c2p payment result: $result');

      Map<String, dynamic> responseJson = json.decode(result!);

      String uniqueTransactionCode = responseJson["uniqueTransactionCode"];
      //String amount = responseJson["amt"];

      print('----amount: ${responseJson["amt"]}');
      print('----uniqueTransactionCode: ${responseJson["uniqueTransactionCode"]}');

      if (uniqueTransactionCode.isNotEmpty) {
        billPayCubit.initiateBillPayment(_userId, uniqueTransactionCode, totalBill, 'Payment Gateway');
      } else {
        edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Payment Failed', gravity: Gravity.top);
      }
    } catch (e) {
      print('----Error : $e');
    }
  }


  void getLocalData() async {
    await AuthenticationLocalDataSourceImpl().getSessionId().then((userId) =>
    {
      if (userId != null)
        {
          _userId = userId,
          billCubit.initiateBill(userId)
        }
    });

    await AuthenticationLocalDataSourceImpl().getWalletBalance().then((amount) => {
      setState(() {
        walletBalance = amount ?? '00.00 ';
      })
    });
  }
}