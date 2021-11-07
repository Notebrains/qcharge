import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/common/extensions/validation.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_model_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/register_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/qr_code/mySharedPreferences.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';
import 'package:qcharge_flutter/presentation/widgets/select_drop_list.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_brand_cubit.dart';

class RegisterForm extends StatefulWidget {
  final Function isProcessCompleted;
  const RegisterForm({Key? key, required this.isProcessCompleted}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late File? xFile = File('');
  String base64Image = '';
  bool isEnabled = true ;
  late TextEditingController? _mobileController, _passwordController, _firstNameController, _lastNameController, _emailController,
      _confPasswordController;

  DropListModel carBrandDropDownList = DropListModel([]);
  DropListModel carModelDropDownList = DropListModel([]);
  OptionItem optionItemSelected = OptionItem(id: '0', title: "Select car brand *");
  OptionItem optionItemSelected2 = OptionItem(id: '0', title: "Select car model *");

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();

    _firstNameController?.addListener(() {
      setState(() {
        isEnabled = (_firstNameController?.text.isNotEmpty ?? false);
      });
    });

    _lastNameController?.addListener(() {
      setState(() {
        isEnabled = (_lastNameController?.text.isNotEmpty ?? false);
      });
    });

    _emailController?.addListener(() {
      setState(() {
        isEnabled = (_emailController?.text.isNotEmpty ?? false);
      });
    });

    _mobileController?.addListener(() {
      setState(() {
        isEnabled = (_mobileController?.text.isNotEmpty ?? false);
      });
    });

    _passwordController?.addListener(() {
      setState(() {
        isEnabled = (_mobileController?.text.isNotEmpty ?? false);
      });
    });

    _confPasswordController?.addListener(() {
      setState(() {
        isEnabled = (_confPasswordController?.text.isNotEmpty ?? false) &&
            (_passwordController?.text == _confPasswordController?.text);
      });
    });

  }

  Future getImage() async {
    try {
      final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

      setState(() {
            xFile = File(imageFile!.path);
            //print('Image Path $xFile');
          });
    } catch (e) {
      print(e);
    }
  }

  setImage(String path) {
    try {
      print('----path: $path');
      if (path.isEmpty) {
            return cachedNetImgWithRadius(
              Strings.imgUrlNotFoundYellowAvatar,
              110,
              110,
              30,
            );
          } else {
            final bytes = File(path).readAsBytesSync();
            base64Image = base64Encode(bytes);
            //print('-----base64Image:  $base64Image');

            return CircleAvatar(
              radius: 57,
              backgroundColor : Colors.amber,
              child: ClipOval(
                child: SizedBox(
                  width: 111.0,
                  height: 111.0,
                  child: Image.file(
                    File(xFile!.path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          }
    } catch (e) {
      print(e);
    }
  }


  @override
  void dispose() {
    _mobileController?.dispose();
    _passwordController?.dispose();
    _firstNameController?.dispose();
    _lastNameController?.dispose();
    _emailController?.dispose();
    _confPasswordController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                getImage();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: setImage(xFile!.path),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(8, 12, 8, 0),
              child: IcIfRow(txt: 'Full name *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_6.png', icColor: Colors.white,
                hint: 'Enter first name *', textInputType: TextInputType.text,
                controller: _firstNameController, obscureText: false,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: IcIfRow(txt: 'Last name *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_6.png', icColor: Colors.white,
                hint: 'Enter last name *', textInputType: TextInputType.text,
                controller: _lastNameController, obscureText: false,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: IcIfRow(txt: 'Email *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_7.png', icColor: Colors.white,
                hint: 'Enter email *', textInputType: TextInputType.text,
                controller: _emailController, obscureText: false,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: IcIfRow(txt: 'Password *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_8.png', icColor: Colors.white,
                hint: 'Enter password *', textInputType: TextInputType.visiblePassword,
                controller: _passwordController, obscureText: true,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: IcIfRow(txt: 'Confirm password *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_9.png', icColor: Colors.white,
                hint: 'Enter confirm password *', textInputType: TextInputType.visiblePassword,
                controller: _confPasswordController, obscureText: true,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
              child: IcIfRow(txt: 'Mobile number *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_1.png', icColor: Colors.white,
                hint: 'Enter mobile number *', textInputType: TextInputType.phone,
                controller: _mobileController, obscureText: false,
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: Button(text: TranslationConstants.register.t(context),
                bgColor: isEnabled? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Colors.grey.shade400, Colors.grey.shade400],
                onPressed: () {
                  if (_mobileController!.text.isEmpty  || _mobileController!.text.length < 7 || _mobileController!.text.length > 14) {
                    edgeAlert(context, title: 'Warning', description: 'Please enter valid mobile number', gravity: Gravity.top);
                  } else if(_firstNameController!.text.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please enter first name', gravity: Gravity.top);
                  } else if(_lastNameController!.text.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please enter last name', gravity: Gravity.top);
                  } else if(!validateEmail(_emailController!.text)){
                    edgeAlert(context, title: 'Warning', description: 'Please enter valid email id', gravity: Gravity.top);
                  } else if(_passwordController!.text.isEmpty || _passwordController!.text.length < 5){
                    edgeAlert(context, title: 'Warning', description: 'Please enter minimum 5 digit password ', gravity: Gravity.top);
                  }  else if(_confPasswordController!.text.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please enter confirm password', gravity: Gravity.top);
                  } else if(_passwordController!.text != _confPasswordController!.text){
                    edgeAlert(context, title: 'Warning', description: 'Password and confirm password did not matched', gravity: Gravity.top);
                  }  else if (isEnabled) {
                      //ch
                      BlocProvider.of<RegisterCubit>(context).initiateRegister(
                        _firstNameController?.text ?? '',
                        _lastNameController?.text ?? '',
                        _emailController?.text ?? '',
                        _mobileController?.text ?? '',
                        _passwordController?.text ?? '',
                        _confPasswordController?.text ?? '',
                        '0',
                        '0',
                        '0',
                        '0',
                        base64Image,
                      );
                  }
                },
              ),
            ),

            BlocConsumer<RegisterCubit, RegisterState>(
              buildWhen: (previous, current) => current is RegisterError,
              builder: (context, state) {
                if (state is RegisterError)
                  return Text(
                    state.message.t(context),
                    style: TextStyle(color: Colors.black),
                  );
                return const SizedBox.shrink();
              },
              listenWhen: (previous, current) => current is RegisterSuccess,
              listener: (context, state) {
                /*Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteList.initial, (route) => false,
                );*/

                if (state is RegisterSuccess) {
                  if (state.model.status == 1) {
                    MySharedPreferences().addUserName("${_firstNameController!.text} ${_lastNameController!.text}");
                    edgeAlert(
                      context,
                      duration: 2,
                      icon: Icons.light_mode_rounded,
                      title: 'Note',
                      description: 'Registration Successful',
                      gravity: Gravity.top,
                    );
                    widget.isProcessCompleted();
                  } else {
                    edgeAlert(
                      context,
                      duration: 2,
                      icon: Icons.light_mode_rounded,
                      title: 'Note',
                      description: state.model.message!,
                      gravity: Gravity.top,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
