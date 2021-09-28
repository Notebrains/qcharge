import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/update_profile_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';

class UpdateProfile extends StatefulWidget {

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late UpdateProfileCubit updateProfileCubit;

  late File? xFile = File('');
  bool isEnabled = true ;
  late TextEditingController? _mobileController, _passwordController, _firstNameController, _lastNameController, _emailController,
      _confPasswordController;


  @override
  void initState() {
    super.initState();

    updateProfileCubit = getItInstance<UpdateProfileCubit>();

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

    //BlocProvider.of<CarBrandCubit>(context).loadCarBrand();
    //BlocProvider.of<CarModelCubit>(context).loadCarModel('1');
  }

  Future getImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      xFile = File(imageFile!.path);
      print('Image Path $xFile');
    });
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
      body: BlocProvider<UpdateProfileCubit>(
        create: (context) => updateProfileCubit,
        child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            bloc: updateProfileCubit,
            builder: (context, state) {
              return  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 45,
                            backgroundColor : Colors.grey.shade700,
                            child: ClipOval(
                              child: new SizedBox(
                                width: 80.0,
                                height: 80.0,
                                child: Image.file(
                                  xFile!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.add_photo_alternate_rounded,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                      child: IcIfRow(txt: 'Full name *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_6.png', icColor: Colors.white,
                        hint: 'Enter first name *', textInputType: TextInputType.text,
                        controller: _firstNameController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: IcIfRow(txt: 'Last name *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_6.png', icColor: Colors.white,
                        hint: 'Enter last name *', textInputType: TextInputType.text,
                        controller: _lastNameController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: IcIfRow(txt: 'Email *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_7.png', icColor: Colors.white,
                        hint: 'Enter email *', textInputType: TextInputType.text,
                        controller: _emailController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: IcIfRow(txt: 'Password *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_8.png', icColor: Colors.white,
                        hint: 'Enter password *', textInputType: TextInputType.visiblePassword,
                        controller: _passwordController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: IcIfRow(txt: 'Confirm password *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_9.png', icColor: Colors.white,
                        hint: 'Enter confirm password *', textInputType: TextInputType.visiblePassword,
                        controller: _confPasswordController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: IcIfRow(txt: 'Mobile number *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_1.png', icColor: Colors.white,
                        hint: 'Enter mobile number *', textInputType: TextInputType.phone,
                        controller: _mobileController,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: Button(text: TranslationConstants.register.t(context),
                        bgColor: isEnabled? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Colors.grey.shade400, Colors.grey.shade400],
                        onPressed: () {
                          if (_mobileController!.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description: 'Please enter mobile number', gravity: Gravity.top);
                          } else if(_passwordController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter password', gravity: Gravity.top);
                          } else if(_firstNameController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter first name', gravity: Gravity.top);
                          } else if(_lastNameController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter last name', gravity: Gravity.top);
                          } else if(_emailController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter email id', gravity: Gravity.top);
                          } else if(_confPasswordController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter confirm password', gravity: Gravity.top);
                          } else {
                            if (isEnabled) {
                              BlocProvider.of<UpdateProfileCubit>(context).initiateUpdateProfile(
                                _firstNameController?.text ?? '',
                                _lastNameController?.text ?? '',
                                _emailController?.text ?? '',
                                _mobileController?.text ?? '',
                                _passwordController?.text ?? '',
                                _confPasswordController?.text ?? '',
                              );
                            }
                          }
                        },
                      ),
                    ),


                    BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                      buildWhen: (previous, current) => current is UpdateProfileError,
                      builder: (context, state) {
                        if (state is UpdateProfileError)
                          return Text(
                            state.message.t(context),
                            style: TextStyle(color: Colors.black),
                          );
                        return const SizedBox.shrink();
                      },
                      listenWhen: (previous, current) => current is UpdateProfileSuccess,
                      listener: (context, state) {
                        /*Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteList.initial, (route) => false,
                        );*/

                        if (state is UpdateProfileSuccess) {

                        }
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
