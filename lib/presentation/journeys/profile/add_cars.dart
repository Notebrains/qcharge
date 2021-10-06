import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/update_profile_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';


class AddOrUpdateCar extends StatefulWidget {
  final String screenTitle;
  final String carName;
  final String carModel;
  final String carBrand;
  final String carLicencePlate;
  final String carChargingType;

  const AddOrUpdateCar({Key? key, required this.screenTitle, required this.carName,  required this.carModel,  required this.carBrand,
    required this.carLicencePlate,  required this.carChargingType}) : super(key: key);

  @override
  _AddOrUpdateCarState createState() => _AddOrUpdateCarState();
}

class _AddOrUpdateCarState extends State<AddOrUpdateCar> {
  late UpdateProfileCubit updateProfileCubit;

  late File? xFile = File('');
  bool isEnabled = true ;
  late TextEditingController? _carLicencePlateController, _carNamesController, _carBrandController, _carModelController,
      _chargingPlateController;


  @override
  void initState() {
    super.initState();

    updateProfileCubit = getItInstance<UpdateProfileCubit>();

    _carNamesController = TextEditingController();
    _carBrandController = TextEditingController();
    _carModelController = TextEditingController();
    _carLicencePlateController = TextEditingController();
    _chargingPlateController = TextEditingController();

    _carNamesController?.addListener(() {
      setState(() {
        isEnabled = (_carNamesController?.text.isNotEmpty ?? false);
      });
    });

    _carBrandController?.addListener(() {
      setState(() {
        isEnabled = (_carBrandController?.text.isNotEmpty ?? false);
      });
    });

    _carModelController?.addListener(() {
      setState(() {
        isEnabled = (_carModelController?.text.isNotEmpty ?? false);
      });
    });

    _carLicencePlateController?.addListener(() {
      setState(() {
        isEnabled = (_carLicencePlateController?.text.isNotEmpty ?? false);
      });
    });

    _chargingPlateController?.addListener(() {
      setState(() {
        isEnabled = (_chargingPlateController?.text.isNotEmpty ?? false) &&
            (_carLicencePlateController?.text == _chargingPlateController?.text);
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
    _carLicencePlateController?.dispose();
    _carNamesController?.dispose();
    _carBrandController?.dispose();
    _carModelController?.dispose();
    _chargingPlateController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, widget.screenTitle),
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
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 24, left: 16, right: 16),
                            child: setImage(xFile!.path),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 28, right: 22),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 24, 0, 8),
                      child: IcIfRow(txt: 'Car Name *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/profile_screen_8_car.png', icColor: Colors.white,
                        hint: widget.carName, textInputType: TextInputType.text,
                        controller: _carNamesController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: IcIfRow(txt: widget.carBrand, txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/profile_screen_8_car.png', icColor: Colors.white,
                        hint: widget.carBrand, textInputType: TextInputType.text,
                        controller: _carBrandController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: IcIfRow(txt: 'Car Model *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/profile_screen_8_car.png', icColor: Colors.white,
                        hint: widget.carModel, textInputType: TextInputType.text,
                        controller: _carModelController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: IcIfRow(txt: 'Car licence plate *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/account_Register_10.png', icColor: Colors.white,
                        hint: widget.carLicencePlate, textInputType: TextInputType.visiblePassword,
                        controller: _carLicencePlateController,
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: IcIfRow(txt: 'Charging type *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                        icon: 'assets/icons/pngs/filter_0011_AC.png', icColor: Colors.white70,
                        hint: widget.carChargingType, textInputType: TextInputType.visiblePassword,
                        controller: _chargingPlateController,
                      ),
                    ),

                    Container(
                      width: 270,
                      padding: const EdgeInsets.only(right: 6, top: 45),
                      child: Button(text: widget.screenTitle == 'Add Car'?  'SAVE' : 'UPDATE',
                        bgColor: isEnabled? [Color(0xFFEFE07D), Color(0xFFB49839)] : [Colors.grey.shade400, Colors.grey.shade400],
                        onPressed: () {
                          if(_carLicencePlateController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter password', gravity: Gravity.top);
                          } else if(_carNamesController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter first name', gravity: Gravity.top);
                          } else if(_carBrandController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter last name', gravity: Gravity.top);
                          } else if(_carModelController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter email id', gravity: Gravity.top);
                          } else if(_chargingPlateController!.text.isEmpty){
                            edgeAlert(context, title: 'Warning', description: 'Please enter confirm password', gravity: Gravity.top);
                          } else {
                            if (isEnabled) {
                              BlocProvider.of<UpdateProfileCubit>(context).initiateUpdateProfile(
                                _carNamesController?.text ?? '',
                                _carBrandController?.text ?? '',
                                _carModelController?.text ?? '',
                                _carLicencePlateController?.text ?? '',
                                _chargingPlateController?.text ?? '',
                                ''
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
        Strings.imgUrlMeeting,
        double.infinity,
        200,
        6,
      );
    } else return Image.file(File(xFile!.path), width: double.infinity, height: 200,);
  }
}
