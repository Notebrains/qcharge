import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/sliding_entrances/slide_in_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/login/forgot_pass_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_if_ic_round.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State {
  TextEditingController _controller = TextEditingController();
  String mobile = '';
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  late ForgotPasswordCubit forgotPasswordCubit;

  @override
  void initState() {
    super.initState();

    forgotPasswordCubit = getItInstance<ForgotPasswordCubit>();
  }

  @override
  void dispose() {
    super.dispose();

    forgotPasswordCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarHome(context),
      body: BlocProvider<ForgotPasswordCubit>(
          create: (context) => forgotPasswordCubit,
          child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              bloc: forgotPasswordCubit,
              builder: (context, state) {
                return Form(
                  key: _key,
                  autovalidateMode: AutovalidateMode.always,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SlideInUp(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 24),
                            child: Text(
                              TranslationConstants.forgotPassSuggestionTxt.t(context),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
                            ),
                          ),
                          preferences: AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 700)),
                        ),

                        SlideInUp(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: IfIconRound(
                              hint: TranslationConstants.mobNo.t(context),
                              icon: Icons.phone_android_sharp,
                              controller: _controller,
                              textInputType: TextInputType.phone,
                            ),
                          ),
                          preferences: AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 750)),
                        ),

                        SlideInUp(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
                            child: Button(
                              text: TranslationConstants.sendCaps.t(context),
                              bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                              onPressed: () {
                                if (_controller.text.isEmpty) {
                                  edgeAlert(context, title: 'Warning', description: 'Please enter mobile number', gravity: Gravity.top);
                                } else {
                                  BlocProvider.of<ForgotPasswordCubit>(context).initiateForgotPassword(
                                    _controller.text,
                                  );
                                }
                              },
                            ),
                          ),
                          preferences: AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 800)),
                        ),

                        BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                          buildWhen: (previous, current) => current is ForgotPasswordError,
                          builder: (context, state) {
                            if (state is ForgotPasswordError)
                              return Text(
                                state.message.t(context),
                                style: TextStyle(color: Colors.black),
                              );
                            return const SizedBox.shrink();
                          },
                          listenWhen: (previous, current) => current is ForgotPasswordSuccess,
                          listener: (context, state) {
                            //Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial,(route) => false,);
                            print('---- : ${state.props}');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
      ),
    );
  }
}
