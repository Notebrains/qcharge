import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:qcharge_flutter/presentation/journeys/payments/payment_methods.dart';
import 'package:qcharge_flutter/presentation/journeys/subscription/subscription_details.dart';
import 'package:qcharge_flutter/presentation/libraries/dialog_rflutter/rflutter_alert.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/no_data_found.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

import '../payments/2c2p_payment_gateway.dart';


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
                                                details: state.model.response![i].image!,
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
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentMethods(onTap: (selectedIndex){
                                            print('----selectedIndex : $selectedIndex');
                                            openPaymentGateway(context, selectedIndex);
                                          }),
                                        ),
                                      );
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

  void openPaymentGateway(BuildContext context, int selectedIndex) async {
    try {
      openProductionPaymentGateway(subscriptionPrice, selectedIndex, "Subscription Payment").then((responseJson) => {
      if (responseJson["uniqueTransactionCode"].isNotEmpty && subscriptionPrice.isNotEmpty  && responseJson["respCode"] == '00') {
        purchaseSubscriptionCubit.initiatePurchaseSubscription(
        _userId, responseJson["uniqueTransactionCode"], subscriptionPrice, 'pay', subscriptionId,
      ),
    } else {
      edgeAlert(context, title: TranslationConstants.message.t(context), description: TranslationConstants.paymentFailed.t(context), gravity: Gravity.top),
    }
      });
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
