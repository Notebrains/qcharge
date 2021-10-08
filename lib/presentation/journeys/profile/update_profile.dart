import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/update_profile_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';

class UpdateProfile extends StatefulWidget {

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late UpdateProfileCubit updateProfileCubit;

  late File? xFile = File('');
  bool isEnabled = true;
  bool isChangePass = false;

  late TextEditingController? _oldPassController, _passwordController, _firstNameController, _lastNameController, _emailController,
      _confPasswordController;


  @override
  void initState() {
    super.initState();

    updateProfileCubit = getItInstance<UpdateProfileCubit>();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _oldPassController = TextEditingController();
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

    _oldPassController?.addListener(() {
      setState(() {
        isEnabled = (_oldPassController?.text.isNotEmpty ?? false);
      });
    });

    _passwordController?.addListener(() {
      setState(() {
        isEnabled = (_oldPassController?.text.isNotEmpty ?? false);
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
    _oldPassController?.dispose();
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
      appBar: appBarIcBack(context, ''),
      body: BlocProvider<UpdateProfileCubit>(
        create: (context) => updateProfileCubit,
        child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            bloc: updateProfileCubit,
            builder: (context, state) {
              return  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        getImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24, bottom: 24),
                              child: setImage(xFile!.path),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: AppColor.app_txt_amber_light,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 24, 8, 0),
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



                    Visibility(
                      visible: isChangePass,
                      child: FadeIn(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: IcIfRow(txt: 'Old Password *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_1.png', icColor: Colors.white,
                            hint: 'Old Password *', textInputType: TextInputType.phone,
                            controller: _oldPassController,
                          ),
                        ),
                      ),
                    ),


                    Visibility(
                      visible: isChangePass,
                      child: FadeIn(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: IcIfRow(txt: 'Password *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_8.png', icColor: Colors.white,
                            hint: 'Enter password *', textInputType: TextInputType.visiblePassword,
                            controller: _passwordController,
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: isChangePass,
                      child: FadeIn(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: IcIfRow(txt: 'Confirm password *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_9.png', icColor: Colors.white,
                            hint: 'Enter confirm password *', textInputType: TextInputType.visiblePassword,
                            controller: _confPasswordController,
                          ),
                        ),
                      ),
                    ),
                    
                    Container(
                      width: 270,
                      padding: const EdgeInsets.only(right: 6, top: 45),
                      child: Button(text: isChangePass ? 'Hide Change Password' :'Show Change Password',
                        bgColor: isEnabled? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Colors.grey.shade400, Colors.grey.shade400],
                        onPressed: () {
                          setState(() {
                             isChangePass? isChangePass = false : isChangePass = true;
                          });
                        },
                      ),
                    ),


                    Container(
                      width: 270,
                      padding: const EdgeInsets.only(right: 6,),
                      child: Button(text: 'UPDATE',
                        bgColor: isEnabled? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Colors.grey.shade400, Colors.grey.shade400],
                        onPressed: () {
                          if (_oldPassController!.text.isEmpty) {
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
                                _oldPassController?.text ?? '',
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

  setImage(String path){
    print('----path : $path');
    if (path.isEmpty) {
      return cachedNetImgWithRadius(
        Strings.imgUrlNotFoundYellowAvatar,
        110,
        110,
        60,
      );
    } else return ClipOval(
      child: Image.file(File(xFile!.path), width: 110, height: 110,),
    );
  }
}