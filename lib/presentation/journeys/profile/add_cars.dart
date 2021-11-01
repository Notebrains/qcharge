import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/add_update_car_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_brand_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_model_cubit.dart';
import 'package:qcharge_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/ic_if_row.dart';
import 'package:qcharge_flutter/presentation/widgets/select_drop_list.dart';

class AddOrUpdateCar extends StatefulWidget {
  final String screenTitle;
  final String carName;
  String carModel;
  String carBrand;
  String carBrandId;
  String carModelId;
  final String carLicencePlate;
  final String vehicleId;
  String image;

  AddOrUpdateCar(
      {Key? key,
      required this.screenTitle,
      required this.carName,
      required this.carModel,
      required this.carBrand,
      required this.carBrandId,
      required this.carModelId,
      required this.carLicencePlate,
      required this.vehicleId,
      required this.image,
      })
      : super(key: key);

  @override
  _AddOrUpdateCarState createState() => _AddOrUpdateCarState();
}

class _AddOrUpdateCarState extends State<AddOrUpdateCar> {
  late AddUpdateCarCubit addUpdateCarCubit;
  late CarBrandCubit _carBrandCubit;
  late CarModelCubit _carModelCubit;

  DropListModel carBrandDropDownList = DropListModel([]);
  DropListModel carModelDropDownList = DropListModel([]);
  OptionItem optionItemSelected = OptionItem(id: '0', title: "Select car brand *");
  OptionItem optionItemSelected2 = OptionItem(id: '0', title: "Select car model *");

  late File? xFile = File('');

  String base64Image = '';
  late TextEditingController? _carLicencePlateController, _carNamesController;

  bool isCarBrandEditable = true;

  @override
  void initState() {
    super.initState();

    addUpdateCarCubit = getItInstance<AddUpdateCarCubit>();
    _carModelCubit = getItInstance<CarModelCubit>();
    _carBrandCubit = getItInstance<CarBrandCubit>();

    _carNamesController = TextEditingController();
    _carLicencePlateController = TextEditingController();

    _carNamesController?.text = widget.carName;
    _carLicencePlateController?.text = widget.carLicencePlate;

    _carBrandCubit.loadCarBrand();
    _carModelCubit.loadCarModel('1');


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
    addUpdateCarCubit.close();
    _carBrandCubit.close();
    _carModelCubit.close();

    _carLicencePlateController?.dispose();
    _carNamesController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, widget.screenTitle),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: addUpdateCarCubit),
          BlocProvider.value(value: _carBrandCubit),
          BlocProvider.value(value: _carModelCubit),
        ],
        child: BlocBuilder<AddUpdateCarCubit, AddUpdateCarState>(builder: (context, state) {
          return BlocBuilder<CarBrandCubit, CarBrandState>(builder: (context, state) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 24, left: 16, right: 16),
                          child: setImage(xFile!.path, widget.image),
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
                    margin: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                    child: IcIfRow(
                      txt: widget.carName,
                      txtColor: Colors.white,
                      txtSize: 12,
                      fontWeight: FontWeight.normal,
                      icon: 'assets/icons/pngs/profile_screen_8_car.png',
                      icColor: Colors.white,
                      hint: widget.carName.isEmpty? '${TranslationConstants.name.t(context)} *': widget.carName,
                      textInputType: TextInputType.text,
                      controller: _carNamesController,
                    ),
                  ),
                  Visibility(
                    visible: widget.screenTitle != TranslationConstants.addCar.t(context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Image.asset('assets/icons/pngs/profile_screen_8_car.png',
                              width: 24,
                              height: 24,
                              color: Colors.white,
                            ),
                          ),

                          Container(
                            height: 50,
                            width: Sizes.dimen_230.w,
                            margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: widget.carBrand,
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: widget.screenTitle != TranslationConstants.addCar.t(context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Image.asset('assets/icons/pngs/profile_screen_8_car.png',
                              width: 24,
                              height: 24,
                              color: Colors.white,
                            ),
                          ),

                          Container(
                            height: 50,
                            width: Sizes.dimen_230.w,
                            margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: widget.carModel,
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: isCarBrandEditable,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 16, 24, 20),
                      width: 270,
                      child: SelectDropList(
                        ic: Icons.directions_car_outlined,
                        icColor: AppColor.app_txt_white,
                        itemSelected: optionItemSelected,
                        onOptionSelected: (OptionItem optionItem) {
                          //print('----Car brand: ${optionItem.title}');
                          BlocProvider.of<CarModelCubit>(context).loadCarModel(optionItem.id);
                          setState(() {
                            widget.carBrandId = optionItem.id;
                            widget.carBrand = optionItem.title;
                            optionItemSelected.title = optionItem.title;
                            widget.carModelId = '';
                          });
                        },
                        dropListModel: carBrandDropDownList,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isCarBrandEditable,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 24, 12),
                      width: 270,
                      child: SelectDropList(
                        ic: Icons.local_car_wash_outlined,
                        icColor: AppColor.app_txt_white,
                        itemSelected: optionItemSelected2,
                        onOptionSelected: (OptionItem optionItem) {

                          try {
                            if (widget.carBrandId.isNotEmpty) {
                              print('----Car model: ${optionItem.title}');

                              setState(() {
                                widget.carModelId = optionItem.id;
                                widget.carModel = optionItem.title;
                                optionItemSelected2.title = optionItem.title;
                              });
                            } else {
                              edgeAlert(context, title: 'Warning', description: 'Please select car brand first', gravity: Gravity.top);
                            }

                          } catch (e) {
                            print('---- : $e');
                          }
                        },
                        dropListModel: carModelDropDownList,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: IcIfRow(
                      txt: widget.carLicencePlate,
                      txtColor: Colors.white,
                      txtSize: 12,
                      fontWeight: FontWeight.normal,
                      icon: 'assets/icons/pngs/account_Register_10.png',
                      icColor: Colors.white,
                      hint: widget.carLicencePlate.isEmpty? '${TranslationConstants.carLicencePlate.t(context)} *': widget.carLicencePlate,
                      textInputType: TextInputType.visiblePassword,
                      controller: _carLicencePlateController,
                    ),
                  ),
                  Container(
                    width: 270,
                    padding: const EdgeInsets.only(right: 6, top: 45),
                    child: Button(
                      text: widget.screenTitle == TranslationConstants.addCar.t(context)
                          ? TranslationConstants.save.t(context)
                          : TranslationConstants.updateCar.t(context),
                      bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
                      onPressed: () async {
                        if (_carNamesController!.text.isEmpty) {
                          edgeAlert(context, title: 'Warning', description: 'Please enter car name', gravity: Gravity.top);
                        } else if (_carLicencePlateController!.text.isEmpty) {
                          edgeAlert(context, title: 'Warning', description: 'Please enter car plate licence', gravity: Gravity.top);
                        } else if(widget.carBrandId.isEmpty){
                          edgeAlert(context, title: 'Warning', description: 'Please enter car brand', gravity: Gravity.top);
                        } else if(widget.carModelId.isEmpty){
                          edgeAlert(context, title: 'Warning', description: 'Please select car model', gravity: Gravity.top);
                        } else {
                          await AuthenticationLocalDataSourceImpl().getSessionId().then((userId) => {
                                print('---- user id 1: $userId'),
                                if (userId != null)
                                  {
                                    addUpdateCarCubit.initiateAddUpdateCar(
                                        userId,
                                        widget.carBrandId,
                                        widget.carModelId,
                                        _carNamesController?.text ?? '',
                                        _carLicencePlateController?.text ?? '',
                                        widget.vehicleId,
                                        widget.screenTitle == TranslationConstants.addCar.t(context) ? 'add' : 'update',
                                        base64Image,
                                    ),
                                  }
                              });
                        }
                      },
                    ),
                  ),
                  BlocConsumer<AddUpdateCarCubit, AddUpdateCarState>(
                    buildWhen: (previous, current) => current is AddUpdateCarError,
                    builder: (context, state) {
                      if (state is AddUpdateCarError)
                        return Text(
                          state.message.t(context),
                          style: TextStyle(color: Colors.black),
                        );
                      return const SizedBox.shrink();
                    },
                    listenWhen: (previous, current) => current is AddUpdateCarSuccess,
                    listener: (context, state) {
                      /*Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteList.initial, (route) => false,
                        );*/

                      if (state is AddUpdateCarSuccess) {
                        edgeAlert(context, title: 'Message', description: state.model.message!, gravity: Gravity.top);
                        if (state.model.status == 1) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),

                  BlocConsumer<CarBrandCubit, CarBrandState>(
                    buildWhen: (previous, current) => current is CarBrandError,
                    builder: (context, state) {
                      if (state is CarBrandError)
                        return Text(
                          'Could not fetch data',
                          style: TextStyle(color: Colors.black),
                        );
                      return const SizedBox.shrink();
                    },
                    listenWhen: (previous, current) => current is CarBrandLoaded,
                    listener: (context, state) {
                      if (state is CarBrandLoaded) {
                        print('---- Car data loaded: ${state.carBrandEntity[0].name}');
                        var dataList = state.carBrandEntity;
                        for (int i = 0; i < dataList.length; i++) {
                          carBrandDropDownList.listOptionItems.add(
                            OptionItem(
                              id: dataList[i].brandId.toString(),
                              title: dataList[i].name.toString(),
                            ),
                          );
                        }

                        setState(() {});
                      }
                    },
                  ),
                  BlocConsumer<CarModelCubit, CarModelState>(
                    buildWhen: (previous, current) => current is CarModelError,
                    builder: (context, state) {
                      if (state is CarBrandError)
                        return Text(
                          'Could not fetch data',
                          style: TextStyle(color: Colors.black),
                        );
                      return const SizedBox.shrink();
                    },
                    listenWhen: (previous, current) => current is CarModelLoaded,
                    listener: (context, state) {
                      if (state is CarModelLoaded) {
                        print('---- Car data loaded: ${state.carModelEntity[0].name}');
                        var dataList = state.carModelEntity;
                        for (int i = 0; i < dataList.length; i++) {
                          carModelDropDownList.listOptionItems.add(
                            OptionItem(id: dataList[i].id.toString(), title: dataList[i].name.toString()),
                          );
                        }

                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            );
          });
        }),
      ),
    );
  }

  setImage(String path, String image) {
    print('----path: $path');
    if (path.isEmpty) {
      return cachedNetImgWithRadius(
        image,
        double.infinity,
        200,
        4,
      );
    } else {
      final bytes = File(path).readAsBytesSync();
      base64Image = base64Encode(bytes);
      //print('-----base64Image:  $base64Image');

      return Image.file(
        File(xFile!.path),
        width: double.infinity,
        height: 200,
      );
    }
  }
}
