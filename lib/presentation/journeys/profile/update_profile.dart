import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/update_profile_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}


// Page content: if isChangePass = true then pass is mandate else nothing is mandate
class _UpdateProfileState extends State<UpdateProfile> {
  late UpdateProfileCubit updateProfileCubit;

  late File? xFile = File('');
  String base64Image = '';

  bool isChangePass = false;
  String changePassBtnTxt = 'CHANGE PASSWORD';

  late TextEditingController? _oldPassController, _passwordController, _firstNameController, _lastNameController,
      _confPasswordController;


  @override
  void initState() {
    super.initState();

    updateProfileCubit = getItInstance<UpdateProfileCubit>();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _oldPassController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
  }


  Future getImage() async {
    try {
      final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

      setState(() {
            xFile = File(imageFile!.path);
            //print('Image Path $xFile');
          });
    } catch (e) {
      //print(e);
    }
  }

  setImage(String path) {
    try {
      //print('----path: $path');
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
    _oldPassController?.dispose();
    _passwordController?.dispose();
    _firstNameController?.dispose();
    _lastNameController?.dispose();
    _confPasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Update Profile'),
      body: BlocProvider<UpdateProfileCubit>(
        create: (context) => updateProfileCubit,
        child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            bloc: updateProfileCubit,
            builder: (context, state) {
              return SingleChildScrollView(
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
                      margin: const EdgeInsets.fromLTRB(8, 24, 8, 0),
                      child: IcIfRow(txt: 'First name', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_6.png', icColor: Colors.white,
                        hint: 'Enter first name', textInputType: TextInputType.text,
                        controller: _firstNameController,obscureText: false,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: IcIfRow(txt: 'Last name', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_6.png', icColor: Colors.white,
                        hint: 'Enter last name', textInputType: TextInputType.text,
                        controller: _lastNameController,obscureText: false,
                      ),
                    ),

                    Visibility(
                      visible: isChangePass,
                      child: FadeIn(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: IcIfRow(
                            txt: 'Old Password *',
                            txtColor: Colors.white,
                            txtSize: 12,
                            fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_1.png',
                            icColor: Colors.white,
                            hint: 'Old Password *',
                            textInputType: TextInputType.phone,
                            controller: _oldPassController,obscureText: true,
                          ),
                        ),
                      ),
                    ),


                    Visibility(
                      visible: isChangePass,
                      child: FadeIn(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: IcIfRow(
                            txt: 'Password *',
                            txtColor: Colors.white,
                            txtSize: 12,
                            fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_8.png',
                            icColor: Colors.white,
                            hint: 'Enter new password *',
                            textInputType: TextInputType.visiblePassword,
                            controller: _passwordController, obscureText: true,
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: isChangePass,
                      child: FadeIn(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: IcIfRow(
                            txt: 'Confirm password *',
                            txtColor: Colors.white,
                            txtSize: 12,
                            fontWeight: FontWeight.normal,
                            icon: 'assets/icons/pngs/account_Register_9.png',
                            icColor: Colors.white,
                            hint: 'Enter confirm password *',
                            textInputType: TextInputType.visiblePassword,
                            controller: _confPasswordController, obscureText: true,
                          ),
                        ),
                      ),
                    ),


                    Visibility(
                      visible: isChangePass,
                      child: FadeIn(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(60, 12, 50, 8),
                          child: Text(
                            '*Note:  Fill password section only if you want to change your password, else hide it',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10, color: Colors.white60),
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),


                    Container(
                      width: 270,
                      padding: const EdgeInsets.only(right: 6, top: 24),
                      child: Button(
                        text: changePassBtnTxt,
                        bgColor:
                        [Color(0xFFEFE07D), Color(0xFFB49839)],
                        onPressed: () async {
                          setState(() {
                            isChangePass? isChangePass = false : isChangePass = true;
                            isChangePass? changePassBtnTxt = "DON'T CHANGE" : changePassBtnTxt = 'CHANGE PASSWORD';
                          });
                        },
                      ),
                    ),


                    Container(
                      width: 270,
                      padding: const EdgeInsets.only(right: 6, bottom: 50),
                      child: Button(
                        text: 'UPDATE',
                        bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                        onPressed: () async {
                          if (isChangePass && _oldPassController!.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description: 'Please enter old password', gravity: Gravity.top);
                          } else if (isChangePass && _passwordController!.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description: 'Please enter minimum 5 digit password', gravity: Gravity.top);
                          } else if (isChangePass && _confPasswordController!.text.isEmpty) {
                            edgeAlert(context,
                                title: 'Warning', description: 'Please enter confirm password', gravity: Gravity.top);
                          } else if (isChangePass && _confPasswordController!.text != _passwordController!.text) {
                            edgeAlert(context,
                                title: 'Warning',
                                description: 'New password and confirm password did not matched',
                                gravity: Gravity.top);
                          } else {
                            await AuthenticationLocalDataSourceImpl().getSessionId().then((userId) => {
                              //print('---- user id 1: $userId'),
                              if (userId != null)
                                {
                                  BlocProvider.of<UpdateProfileCubit>(context).initiateUpdateProfile(
                                    userId,
                                    _passwordController?.text ?? '',
                                    _firstNameController?.text ?? '',
                                    _lastNameController?.text ?? '',
                                    base64Image,
                                  ),
                                }
                            });
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
                        if (state is UpdateProfileSuccess) {
                          edgeAlert(context, title: 'Message', description: state.model.message!, gravity: Gravity.top);
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
