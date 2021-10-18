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

class _UpdateProfileState extends State<UpdateProfile> {
  late UpdateProfileCubit updateProfileCubit;

  late File? xFile = File('');
  bool isEnabled = true;
  bool isChangePass = false;

  late TextEditingController? _oldPassController, newPasswordController, _confPasswordController;

  @override
  void initState() {
    super.initState();

    updateProfileCubit = getItInstance<UpdateProfileCubit>();

    _oldPassController = TextEditingController();
    newPasswordController = TextEditingController();
    _confPasswordController = TextEditingController();

    _oldPassController?.addListener(() {
      setState(() {
        isEnabled = (_oldPassController?.text.isNotEmpty ?? false);
      });
    });

    newPasswordController?.addListener(() {
      setState(() {
        isEnabled = (newPasswordController?.text.isNotEmpty ?? false);
      });
    });

    _confPasswordController?.addListener(() {
      setState(() {
        isEnabled =
            (_confPasswordController?.text.isNotEmpty ?? false) && (newPasswordController?.text == _confPasswordController?.text);
      });
    });
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
    newPasswordController?.dispose();
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
                    /*InkWell(
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
*/

                    FadeIn(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(8, 50, 8, 8),
                        child: IcIfRow(
                          txt: 'Old Password *',
                          txtColor: Colors.white,
                          txtSize: 12,
                          fontWeight: FontWeight.normal,
                          icon: 'assets/icons/pngs/account_Register_1.png',
                          icColor: Colors.white,
                          hint: 'Old Password *',
                          textInputType: TextInputType.phone,
                          controller: _oldPassController,
                        ),
                      ),
                    ),
                    FadeIn(
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
                          controller: newPasswordController,
                        ),
                      ),
                    ),
                    FadeIn(
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
                          controller: _confPasswordController,
                        ),
                      ),
                    ),
                    Container(
                      width: 270,
                      padding: const EdgeInsets.only(right: 6, top: 70),
                      child: Button(
                        text: 'UPDATE',
                        bgColor:
                            isEnabled ? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Colors.grey.shade400, Colors.grey.shade400],
                        onPressed: () async {
                          if (_oldPassController!.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description: 'Please enter old password', gravity: Gravity.top);
                          } else if (newPasswordController!.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description: 'Please enter new password', gravity: Gravity.top);
                          } else if (_confPasswordController!.text.isEmpty) {
                            edgeAlert(context,
                                title: 'Warning', description: 'Please enter confirm password', gravity: Gravity.top);
                          } else if (_confPasswordController!.text != newPasswordController!.text) {
                            edgeAlert(context,
                                title: 'Warning',
                                description: 'New password and confirm password did not matched',
                                gravity: Gravity.top);
                          } else {
                            if (isEnabled) {
                              await AuthenticationLocalDataSourceImpl().getSessionId().then((userId) => {
                                    print('---- user id 1: $userId'),
                                    if (userId != null)
                                      {
                                        BlocProvider.of<UpdateProfileCubit>(context).initiateUpdateProfile(
                                          userId,
                                          newPasswordController?.text ?? '',
                                        ),
                                      }
                                  });
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

  setImage(String path) {
    print('----path : $path');
    if (path.isEmpty) {
      return cachedNetImgWithRadius(
        Strings.imgUrlNotFoundYellowAvatar,
        110,
        110,
        60,
      );
    } else
      return ClipOval(
        child: Image.file(
          File(xFile!.path),
          width: 110,
          height: 110,
        ),
      );
  }
}
