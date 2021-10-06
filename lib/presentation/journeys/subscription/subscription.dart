import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/sliding_entrances/slide_in_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/subscription_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/subscription/subscription_details.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

class Subscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubscriptionState();
  }
}

class _SubscriptionState extends State {
  TextEditingController _controller = TextEditingController();
  String mobile = '';
  late SubscriptionCubit _subscriptionCubit;
  int selectedIndex = -55;

  @override
  void initState() {
    super.initState();

    _subscriptionCubit = getItInstance<SubscriptionCubit>();
  }

  @override
  void dispose() {
    super.dispose();

    _subscriptionCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarHome(context),
      body: BlocProvider<SubscriptionCubit>(
        create: (context) => _subscriptionCubit,
        child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
            bloc: _subscriptionCubit,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SlideInUp(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 24),
                        child: Text(
                          'Subscription Plans',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                        ),
                      ),
                      preferences:
                          AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 700)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h, horizontal: 12),
                      height: Sizes.dimen_80.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          3,
                          (i) => InkWell(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: Sizes.dimen_120.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedIndex == i ? AppColor.app_bg : AppColor.grey,
                                border: Border.all(color: selectedIndex == i ? AppColor.app_txt_amber_light : AppColor.border,),
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Txt(
                                    txt: 'VIP ${i+1}',
                                    txtColor: AppColor.app_txt_amber_light,
                                    txtSize: 16,
                                    fontWeight: FontWeight.bold,
                                    padding: 1,
                                    onTap: () {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 35),
                                    child: Txt(
                                      txt: '\$100.00',
                                      txtColor: AppColor.app_txt_amber_light,
                                      txtSize: 17,
                                      fontWeight: FontWeight.bold,
                                      padding: 1,
                                      onTap: () {},
                                    ),
                                  ),
                                  Txt(
                                    txt: 'Monthly',
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
                                              'Details',
                                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10, color: AppColor.app_txt_amber_light),
                                              maxLines: 4,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),

                                          Icon(Icons.arrow_right, size: 15, color: AppColor.app_txt_amber_light,),
                                        ],
                                      ),
                                    ),

                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SubscriptionDetails()
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SlideInUp(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
                        child: Button(
                          text: 'SUBSCRIBE',
                          bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                          onPressed: () {
                            if (_controller.text.isEmpty) {
                              edgeAlert(context, title: 'Warning!', description: 'Please one of the subscription', gravity: Gravity.top);
                            } else {
                              BlocProvider.of<SubscriptionCubit>(context).initiateSubscription(
                                _controller.text,
                              );
                            }
                          },
                        ),
                      ),
                      preferences:
                          AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 800)),
                    ),
                    BlocConsumer<SubscriptionCubit, SubscriptionState>(
                      buildWhen: (previous, current) => current is SubscriptionError,
                      builder: (context, state) {
                        if (state is SubscriptionError)
                          return Text(
                            state.message.t(context),
                            style: TextStyle(color: Colors.black),
                          );
                        return const SizedBox.shrink();
                      },
                      listenWhen: (previous, current) => current is SubscriptionSuccess,
                      listener: (context, state) {
                        //Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial,(route) => false,);
                        print('---- : ${state.props}');
                      },
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
