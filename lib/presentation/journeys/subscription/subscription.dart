import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my2c2psdk/models/my2c2psdk_type.dart';
import 'package:my2c2psdk/my2c2psdk.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/cancel_subscription_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/profile_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/purchase_subscription_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/home/subscription_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/subscription/subscription_details.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';


class Subscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubscriptionState();
  }
}

class _SubscriptionState extends State {
  late SubscriptionCubit _subscriptionCubit;
  late CancelSubscriptionCubit cancelSubscriptionCubit;
  late PurchaseSubscriptionCubit purchaseSubscriptionCubit;
  late ProfileCubit profileCubit;

  String subscriptionId = '';
  String subscriptionPrice = '';
  bool isSubscriptionActive = false;
  int selectedIndex = -55;
  String _userId = '';
  String walletBalance = '0.00';

  @override
  void initState() {
    super.initState();

    _subscriptionCubit = getItInstance<SubscriptionCubit>();
    cancelSubscriptionCubit = getItInstance<CancelSubscriptionCubit>();
    purchaseSubscriptionCubit = getItInstance<PurchaseSubscriptionCubit>();
    profileCubit = getItInstance<ProfileCubit>();

    getSubscriptionData();
  }

  @override
  void dispose() {
    super.dispose();

    _subscriptionCubit.close();
    cancelSubscriptionCubit.close();
    purchaseSubscriptionCubit.close();
    profileCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarHome(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _subscriptionCubit),
          BlocProvider.value(value: cancelSubscriptionCubit),
          BlocProvider.value(value: purchaseSubscriptionCubit),
          BlocProvider.value(value: profileCubit),
        ],
        child: BlocBuilder<CancelSubscriptionCubit, CancelSubscriptionState>(builder: (context, state) {
          return BlocBuilder<SubscriptionCubit, SubscriptionState>(builder: (context, state) {
            if (state is SubscriptionSuccess) {
              for (int i = 0; i < state.model.response!.length; i++) {
                if (state.model.response![i].activePlan == 1) {
                  selectedIndex = i;
                  isSubscriptionActive = true;
                  subscriptionId = (state.model.response![i].id).toString();

                }
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 24),
                      child: Text(
                        TranslationConstants.subscribePlan.t(context),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.app_txt_amber_light),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 12),
                      height: Sizes.dimen_230.w,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          state.model.response!.length, (i) =>
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: Sizes.dimen_120.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedIndex == i ? Colors.white38 : AppColor.grey,
                                  border: Border.all(color: selectedIndex == i ? AppColor.app_txt_amber_light : AppColor.border,),
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Txt(
                                      txt: state.model.response![i].membershipName!,
                                      txtColor: AppColor.app_txt_amber_light,
                                      txtSize: 12,
                                      fontWeight: FontWeight.bold,
                                      padding: 1,
                                      onTap: () {},
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 35),
                                      child: Txt(
                                        txt: '${state.model.response![i].membershipPrice!} THB',
                                        txtColor: AppColor.app_txt_amber_light,
                                        txtSize: 17,
                                        fontWeight: FontWeight.bold,
                                        padding: 1,
                                        onTap: () {},
                                      ),
                                    ),
                                    Txt(
                                      txt: TranslationConstants.monthly.t(context),
                                      txtColor: AppColor.border,
                                      txtSize: 11,
                                      fontWeight: FontWeight.bold,
                                      padding: 1,
                                      onTap: () {},
                                    ),


                                    InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 35),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 3),
                                              child: Text(
                                                TranslationConstants.details.t(context),
                                                style: TextStyle(fontWeight: FontWeight.normal,
                                                    fontSize: 10,
                                                    color: AppColor.app_txt_amber_light),
                                                maxLines: 4,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),

                                            Icon(Icons.arrow_right, size: 15, color: AppColor.app_txt_amber_light,),
                                          ],
                                        ),
                                      ),

                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>
                                              SubscriptionDetails(
                                                subscriptionTitle: state.model.response![i].membershipName!,
                                                details: state.model.response![i].description!,
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedIndex = i;
                                  subscriptionId = (state.model.response![i].id).toString();
                                  subscriptionPrice = (state.model.response![i].membershipPrice).toString();
                                });
                              },
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
                      child: Button(
                        text: !isSubscriptionActive ? TranslationConstants.subscribeCaps.t(context) :
                        TranslationConstants.cancelSubs.t(context).toUpperCase(),
                        bgColor: !isSubscriptionActive ? [Color(0xFFEFE07D), Color(0xFFB49839)] :
                        [Color(0xFFFFD5AD), Color(0xFFD46817)],
                        onPressed: () {
                          if (!isSubscriptionActive) {
                            if (subscriptionId.isEmpty) {
                              edgeAlert(context, title: TranslationConstants.warning.t(context),
                                  description: TranslationConstants.selectSubsTxt.t(context),
                                  gravity: Gravity.top);
                            } else {
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
                                      purchaseSubscriptionCubit.initiatePurchaseSubscription(
                                        _userId, 'wallet${(Random().nextInt(912319541) + 12319541).toString()}', state.model.response![selectedIndex].membershipPrice!, 'Wallet', subscriptionId,
                                      );
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
                                      if(subscriptionPrice.isNotEmpty)openPaymentGateway();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      TranslationConstants.payOnline.t(context),
                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                    ),
                                  )
                                ],
                              ).show();
                            }
                          } else {

                            Alert(
                              context: context,
                              title: TranslationConstants.cancelSubs.t(context),
                              desc: TranslationConstants.cancelSubsTxt.t(context),
                              image: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Image.asset("assets/images/unsubscribe.png", width: 170, height: 170,),
                              ),
                              buttons: [
                                DialogButton(
                                  color: Colors.amber,
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    TranslationConstants.no.t(context),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                                DialogButton(
                                  color: Colors.amber,
                                  onPressed: () {
                                    cancelSubscriptionCubit.initiateCancelSubscription(_userId, subscriptionId);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    TranslationConstants.yes.t(context),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                )
                              ],
                            ).show();
                          }
                        },
                      ),
                    ),

                    BlocConsumer<CancelSubscriptionCubit, CancelSubscriptionState>(
                      buildWhen: (previous, current) => current is CancelSubscriptionError,
                      builder: (context, state) {
                        if (state is CancelSubscriptionError)
                          return Text(
                            'Could not fetch data',
                            style: TextStyle(color: Colors.black),
                          );
                        return const SizedBox.shrink();
                      },
                      listenWhen: (previous, current) => current is CancelSubscriptionSuccess,
                      listener: (context, state) {
                        if (state is CancelSubscriptionSuccess) {
                          profileCubit.initiateProfile(_userId);
                          edgeAlert(context, title: TranslationConstants.message.t(context), description: state.model.message!, gravity: Gravity.top);
                        }
                      },
                    ),

                    BlocConsumer<PurchaseSubscriptionCubit, PurchaseSubscriptionState>(
                      buildWhen: (previous, current) => current is PurchaseSubscriptionError,
                      builder: (context, state) {
                        if (state is PurchaseSubscriptionError)
                          return Text(
                            'Could not fetch data',
                            style: TextStyle(color: Colors.black),
                          );
                        return const SizedBox.shrink();
                      },
                      listenWhen: (previous, current) => current is PurchaseSubscriptionSuccess,
                      listener: (context, state) {
                        if (state is PurchaseSubscriptionSuccess) {
                          edgeAlert(context, title: TranslationConstants.message.t(context), description: state.model.message!, gravity: Gravity.top);
                          profileCubit.initiateProfile(_userId);
                        }
                      },
                    ),
                  ],
                ),
              );
            } else {
              return NoDataFound(txt: TranslationConstants.noDataFound.t(context), onRefresh: () {
                setState(() {

                });
              });
            }
          });
        }),
      ),
    );
  }



  void openPaymentGateway() async {
    try {
      final sdk = My2c2pSDK(
        privateKey:
        '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',
      );
      sdk.paymentUI = true; // false to direct payment and true to see payment ui to manual payment
      sdk.productionMode = false;
      sdk.merchantId = "764764000001966";
      //sdk.uniqueTransactionCode = "1015091923644";
      sdk.uniqueTransactionCode = (Random().nextInt(912319541) + 12319541).toString();
      sdk.desc = "product item 1";
      sdk.amount = double.parse(subscriptionPrice);
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
      String amount = responseJson["amt"];

      print('----amount: ${responseJson["amt"]}');
      print('----uniqueTransactionCode: ${responseJson["uniqueTransactionCode"]}');

      if (uniqueTransactionCode.isNotEmpty && subscriptionPrice.isNotEmpty) {
        purchaseSubscriptionCubit.initiatePurchaseSubscription(
          _userId, uniqueTransactionCode, subscriptionPrice, 'pay', subscriptionId,
        );
      } else {
        edgeAlert(context, title: TranslationConstants.message.t(context), description: 'Payment Failed', gravity: Gravity.top);
      }
    } catch (e) {
      print('----Error : $e');
    }
  }

  void getSubscriptionData() async {
    await AuthenticationLocalDataSourceImpl().getSessionId().then((userId) =>
    {
      if (userId != null)
        {
          _userId = userId,
          _subscriptionCubit.initiateSubscription(userId),
        }
    });

    await AuthenticationLocalDataSourceImpl().getWalletBalance().then((amount) => {
      setState(() {
        walletBalance = amount ?? '00.00 ';
      })
    });
  }
}
