import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/verify/req_otp_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/verify/verify_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_if_ic_round.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

class Verify extends StatefulWidget {
  final Function isProcessCompleted;

  const Verify({Key? key, required this.isProcessCompleted}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isOtpEnable = false;
  String btnTxt = 'sendOtp';
  late VerifyCubit _verifyCubit;
  late ReqOtpCubit _reqOtpCubit;
  late TextEditingController? _mobController;
  late TextEditingController? _otpController;


  @override
  void initState() {
    super.initState();

    _verifyCubit = getItInstance<VerifyCubit>();
    _reqOtpCubit = getItInstance<ReqOtpCubit>();

    _mobController = TextEditingController();
    _otpController = TextEditingController();
    _otpController!.text = "501233";

  }

  @override
  void dispose() {
    _verifyCubit.close();
    _reqOtpCubit.close();
    _mobController?.clear();
    _otpController?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _verifyCubit),
        BlocProvider.value(value: _reqOtpCubit),
      ],
      child: BlocBuilder<VerifyCubit, VerifyState>(
        bloc: _verifyCubit,
        builder: (BuildContext context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(45, 100, 45, 24),
                    child: Txt(txt: TranslationConstants.verifyMobTxt.t(context), txtColor: Colors.white, txtSize: 14,
                      fontWeight: FontWeight.bold, padding: 0, onTap: (){},
                    ),
                  ),

                  IfIconRound(hint: TranslationConstants.mobNo.t(context), icon: Icons.phone_android_sharp,
                    controller: _mobController,
                    textInputType: TextInputType.phone,
                  ),

                  Visibility(
                    visible: btnTxt == 'Verify',
                    child: IfIconRound(hint: 'OTP', icon: Icons.rate_review_rounded,
                      controller: _otpController,
                      textInputType: TextInputType.phone,
                    ),
                  ),

                  Visibility(
                    visible: btnTxt != 'Verify',
                    child: Padding(
                      padding: const EdgeInsets.only(left: 34, right: 34, top: 25),
                      child: Button(text: TranslationConstants.reqOtp.t(context),
                        bgColor:[Color(0xFFEFE07D), Color(0xFFB49839)],
                        onPressed: () {
                          if(_mobController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter mobile no.', gravity: Gravity.top);
                          } else {
                            BlocProvider.of<ReqOtpCubit>(context).initiateSendOtp(_mobController?.text ?? '',);
                          }
                        },
                      ),
                    ),
                  ),

                  Visibility(
                    visible: btnTxt == 'Verify',
                    child: Padding(
                      padding: const EdgeInsets.only(left: 34, right: 34, top: 25),
                      child: Button(text: TranslationConstants.verify.t(context),
                        bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                        onPressed: () {

                          if(_mobController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter mobile no.', gravity: Gravity.top);
                          } else if(_otpController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter OTP', gravity: Gravity.top);
                          } else {
                            BlocProvider.of<VerifyCubit>(context).initiateVerify(
                              _mobController?.text ?? '',
                              _otpController?.text ?? '',
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 25),
                    child: Txt(txt: TranslationConstants.resendOtp.t(context), txtColor: Colors.white, txtSize: 14,
                      fontWeight: FontWeight.bold, padding: 0, onTap: (){
                        if(_mobController!.text.isEmpty){
                          edgeAlert(context, title: 'Warning', description: 'Please enter mobile no.', gravity: Gravity.top);
                        } else {
                          BlocProvider.of<ReqOtpCubit>(context).initiateSendOtp(_mobController?.text ?? '',);
                        }
                      },
                    ),
                  ),

                  BlocConsumer<ReqOtpCubit, ReqOtpState>(
                    buildWhen: (previous, current) => current is ReqOtpError,
                    builder: (context, state) {
                      if (state is ReqOtpError)
                        return Text(
                          state.message.t(context),
                          style: TextStyle(color: Colors.black),
                        );
                      return const SizedBox.shrink();
                    },
                    listenWhen: (previous, current) => current is ReqOtpSuccess,
                    listener: (context, state) {
                      if (state is ReqOtpSuccess) {
                          edgeAlert(context, title: 'Warning', description: state.model.message!, gravity: Gravity.top);

                        if (state.model.message == "OTP send successfully.") {
                          setState(() {
                            btnTxt = 'Verify';
                          });
                        }
                      }

                    },
                  ),

                  BlocConsumer<VerifyCubit, VerifyState>(
                    buildWhen: (previous, current) => current is VerifyError,
                    builder: (context, state) {
                      if (state is VerifyError)
                        return Text(
                          state.message.t(context),
                          style: TextStyle(color: Colors.black),
                        );
                      return const SizedBox.shrink();
                    },
                    listenWhen: (previous, current) => current is VerifySuccess,
                    listener: (context, state) {
                      if (state is VerifySuccess) {
                        if (state.model.message == "Mobile verify successfully.") {
                          edgeAlert(context, title: 'Warning', description: state.model.message! + '\n Register now.', gravity: Gravity.top);
                          widget.isProcessCompleted();
                        } else {
                          edgeAlert(context, title: 'Warning', description: state.model.message!, gravity: Gravity.top);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
