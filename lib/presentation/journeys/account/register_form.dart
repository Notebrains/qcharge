import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_model_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/register_cubit.dart';
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
  String carBrandId = '', carModelId = '';
  late TextEditingController? _mobileController, _passwordController, _firstNameController, _lastNameController, _emailController,
      _confPasswordController, _carModelController, _carNameController, _carBrandController, _carLicencePlateController;

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
    _carNameController = TextEditingController();
    _carBrandController = TextEditingController();
    _carModelController = TextEditingController();
    _carLicencePlateController = TextEditingController();

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

    _carNameController?.addListener(() {
      setState(() {
        isEnabled = (_carNameController?.text.isNotEmpty ?? false);
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

    BlocProvider.of<CarBrandCubit>(context).loadCarBrand();
    BlocProvider.of<CarModelCubit>(context).loadCarModel('1');
  }

  Future getImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      xFile = File(imageFile!.path);
      print('Image Path $xFile');
    });
  }

  setImage(String path) {
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
      print('-----base64Image:  $base64Image');

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
  }


  @override
  void dispose() {
    _mobileController?.dispose();
    _passwordController?.dispose();
    _firstNameController?.dispose();
    _lastNameController?.dispose();
    _emailController?.dispose();
    _confPasswordController?.dispose();
    _carModelController?.dispose();
    _carNameController?.dispose();
    _carBrandController?.dispose();
    _carLicencePlateController?.dispose();
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

            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: IcIfRow(txt: 'Car name *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_11.png', icColor: Colors.white,
                hint: 'Enter car name *', textInputType: TextInputType.text,
                controller: _carNameController,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(45, 12, 55, 22),
              child: SelectDropList(
                ic: Icons.directions_car_outlined,
                icColor: AppColor.app_txt_white,
                itemSelected: optionItemSelected,
                onOptionSelected: (OptionItem optionItem) {
                  print('----Car brand: ${optionItem.title}');
                  //BlocProvider.of<CarModelCubit>(context).loadCarModel(optionItem.id);
                  setState(() {
                    carBrandId = optionItem.id;
                    optionItemSelected.title = optionItem.title;
                  });
                },
                dropListModel: carBrandDropDownList,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(45, 0, 55, 12),
              child: SelectDropList(
                ic: Icons.local_car_wash_outlined,
                icColor: AppColor.app_txt_white,
                itemSelected: optionItemSelected2,
                onOptionSelected: (OptionItem optionItem){
                  try{
                    print('----Car model: ${optionItem.title}');

                    setState(() {
                      carModelId = optionItem.id;
                      optionItemSelected2.title = optionItem.title;
                    });
                  } catch (e){
                    print('---- : $e');
                  }
                },
                dropListModel: carModelDropDownList,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 8, 8),
              child: IcIfRow(txt: 'Car licence plate *', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal,
                icon: 'assets/icons/pngs/account_Register_10.png', icColor: Colors.white,
                hint: 'Enter car licence plate *', textInputType: TextInputType.text,
                controller: _carLicencePlateController,
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
                  } else if(carBrandId.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please enter car name', gravity: Gravity.top);
                  } else if(carModelId.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please select car brand', gravity: Gravity.top);
                  } else if(_carNameController!.text.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please select car model', gravity: Gravity.top);
                  } else if(_carLicencePlateController!.text.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please enter car licence plate no.', gravity: Gravity.top);
                  } else if(base64Image.isEmpty){
                    edgeAlert(context, title: 'Warning', description: 'Please pick profile image.', gravity: Gravity.top);
                  } else {
                    if (isEnabled) {
                      BlocProvider.of<RegisterCubit>(context).initiateRegister(
                        _firstNameController?.text ?? '',
                        _lastNameController?.text ?? '',
                        _emailController?.text ?? '',
                        _mobileController?.text ?? '',
                        _passwordController?.text ?? '',
                        _confPasswordController?.text ?? '',
                        _carNameController?.text ?? '',
                        carBrandId,
                        carModelId,
                        _carLicencePlateController?.text ?? '',
                        base64Image,
                      );
                    }
                  }
                },
              ),
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
                  for(int i =0; i<dataList.length; i++){
                    carBrandDropDownList.listOptionItems.add(
                      OptionItem(
                        id: dataList[i].brandId.toString(),
                        title: dataList[i].name.toString(),
                      ),
                    );
                  }

                  setState(() {

                  });
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
                  for(int i =0; i<dataList.length; i++){
                    carModelDropDownList.listOptionItems.add(
                      OptionItem(id: dataList[i].id.toString(), title: dataList[i].name.toString()),
                    );
                  }

                  setState(() {

                  });
                }
              },
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

                  if (state.model.status == 1 && state.model.response!.userId != null) {
                    widget.isProcessCompleted();

                    edgeAlert(
                      context,
                      duration: 2,
                      icon: Icons.light_mode_rounded,
                      title: 'Note',
                      description: 'Registration Successful',
                      gravity: Gravity.top,
                    );
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
