import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_if_ic_round.dart';

import '../../../common/constants/route_constants.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../blocs/login/login_cubit.dart';
import '../../themes/theme_text.dart';
import '../../widgets/button.dart';
import 'label_field_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController? _userNameController, _passwordController;
  bool enableSignIn = false;
  bool isAgreed = true;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController?.addListener(() {
      setState(() {
        enableSignIn = (_userNameController?.text.isNotEmpty ?? false) &&
            (_passwordController?.text.isNotEmpty ?? false);
      });
    });
    _passwordController?.addListener(() {
      setState(() {
        enableSignIn = (_userNameController?.text.isNotEmpty ?? false) &&
            (_passwordController?.text.isNotEmpty ?? false);
      });
    });
  }

  @override
  void dispose() {
    _userNameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_32.w,
          vertical: Sizes.dimen_12.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 5),
              child: Txt(txt: TranslationConstants.welcomeToCaps.t(context), txtColor: Colors.white, txtSize: 14,
                fontWeight: FontWeight.normal, padding: 0, onTap: (){},
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Txt(txt: 'Q CHARGE EV STATION', txtColor: Colors.white, txtSize: 16,
                fontWeight: FontWeight.bold, padding: 0, onTap: (){},
              ),
            ),

            IfIconRound(hint: TranslationConstants.mobNo.t(context), icon: Icons.phone_android_rounded),

            IfIconRound(hint: TranslationConstants.pass.t(context), icon: Icons.lock_rounded),

            Padding(
              padding: const EdgeInsets.only(left: 25,),
              child: CheckboxListTile(
                activeColor: Colors.amber,
                checkColor: Colors.black,
                title: Text(TranslationConstants.rememberMe.t(context),
                  style: TextStyle(fontSize: 13.0),),
                value: isAgreed,
                onChanged: (isChecked) {
                  setState(() {
                    isAgreed = isChecked!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36, top: 12),
              child: Button(text: TranslationConstants.loginCaps.t(context),
                bgColor: Colors.amber,
                onPressed: () {
                  //edgeAlert(context, title: 'Tips', description: 'Please slide to view next screen', gravity: Gravity.top);
                  Navigator.of(context).pushNamed(RouteList.home_screen);
                },
              ),
            ),

            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  TranslationConstants.signup.t(context),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.app_txt_white,
                    decorationThickness: 2,
                    color: Colors.transparent,
                    shadows: [
                      Shadow(
                          color: Colors.white,
                          offset: Offset(0, -8))
                    ],
                  ),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              onTap: (){
                Navigator.of(context).pushNamed(RouteList.registration);
              },
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/pngs/account_Register_8.png',
                  width: 18,
                  height: 18,
                  color: AppColor.border,
                ),

                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
                    child: Text(
                      TranslationConstants.forgotPass.t(context),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.border),
                      maxLines: 4,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  onTap: (){
                    Navigator.of(context).pushNamed(RouteList.forgotPassword);
                  },
                ),
              ],
            ),

            /*BlocConsumer<LoginCubit, LoginState>(
              buildWhen: (previous, current) => current is LoginError,
              builder: (context, state) {
                if (state is LoginError)
                  return Text(
                    state.message.t(context),
                    style: TextStyle(color: Colors.black),
                  );
                return const SizedBox.shrink();
              },
              listenWhen: (previous, current) => current is LoginSuccess,
              listener: (context, state) {

              },
            ),*/
          ],
        ),
      ),
    );
  }
}
