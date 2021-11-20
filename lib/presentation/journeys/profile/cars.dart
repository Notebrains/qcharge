import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/data_sources/authentication_local_data_source.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/delete_car_cubit.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:http/http.dart' as http;
import 'add_cars.dart';

class Cars extends StatefulWidget {

  const Cars({Key? key}) : super(key: key);

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  late DeleteCarCubit deleteCarCubit;
  late Future<bool> _future;
  List<dynamic> carList = [];
  late bool isDataAvailable = false;

  @override
  void initState() {
    super.initState();

    _future = getCarList();
    deleteCarCubit = getItInstance<DeleteCarCubit>();
  }

  @override
  void dispose() {
    super.dispose();

    deleteCarCubit.close();
  }


  Future<bool> getCarList() async{
    String? userId = await AuthenticationLocalDataSourceImpl().getSessionId();
    try{

      Map<String, dynamic> data = Map();
      data["user_id"] = userId.toString();

      http.Response response = await http.post(Uri.parse("https://mridayaitservices.com/demo/qcharge/api/v1/profile/"),
        body: data,
      );
      print("Profile_car res: ${response.body}");

      if(response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        carList = data["response"]["vehicles"];
        if(carList.length > 0)
          isDataAvailable = true;
      }
    } catch(error){
      print("Profile_car: $error");
    }
    return isDataAvailable;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, TranslationConstants.myCar.t(context)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: AppColor.grey,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapShot){
            if(snapShot.hasData){
              if(isDataAvailable){
                return BlocProvider<DeleteCarCubit>(
                  create: (context) => deleteCarCubit,
                  child: BlocBuilder<DeleteCarCubit, DeleteCarState>(
                      bloc: deleteCarCubit,
                      builder: (context, state) {
                        return  Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: carList.length,
                            itemBuilder: (context, position) {
                              return Container(
                                margin: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.grey,
                                  border: Border.all(color: AppColor.border, width: 0.3),
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6)),
                                          child: CachedNetworkImage(
                                            height: 150,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            imageUrl: carList.elementAt(position)["image"].isNotEmpty? carList.elementAt(position)["image"] : Strings.imgUrlCar,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Lottie.asset('assets/animations/lottiefiles/3_line_loading.json', width: 100, height: 100),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                                              child: Text(
                                                carList.elementAt(position)["brand"].toUpperCase(),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    size: 22,
                                                    color: Colors.grey,
                                                  ),

                                                  onTap: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => AddOrUpdateCar(
                                                          screenTitle: TranslationConstants.updateCar.t(context),
                                                          carName: carList.elementAt(position)["car_name"],
                                                          carBrand: carList.elementAt(position)["brand"],
                                                          vehicleId: carList.elementAt(position)["vehicle_id"].toString(),
                                                          carModel: carList.elementAt(position)["model"],
                                                          carLicencePlate: carList.elementAt(position)["car_lisense_plate"],
                                                          carBrandId: carList.elementAt(position)["brand_id"].toString(),
                                                          carModelId: carList.elementAt(position)["model_id"].toString(),
                                                          image: carList.elementAt(position)["image"],

                                                        ),
                                                      ),
                                                    );
                                                    
                                                    setState(() {
                                                      print('---- : getCarList');
                                                      _future = getCarList();
                                                    });
                                                  },
                                                ),
                                                InkWell(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 6, right: 12),
                                                    child: Icon(
                                                      Icons.delete_rounded,
                                                      size: 22,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      deleteCarCubit.initiateDeleteCar(carList.elementAt(position)["vehicle_id"].toString());
                                                      carList.removeAt(position);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 115,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade900,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12, top: 12),
                                            child: Text(
                                              '${TranslationConstants.name.t(context)}: ${carList.elementAt(position)["car_name"]}',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12, top: 6),
                                            child: Text(
                                              '${TranslationConstants.brand.t(context)}: ${carList.elementAt(position)["brand"]}',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12, top: 6),
                                            child: Text(
                                              '${TranslationConstants.model.t(context)}: ${carList.elementAt(position)["model"]}',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12, top: 6),
                                            child: Text(
                                              '${TranslationConstants.licencePlate.t(context)}: ${carList.elementAt(position)["car_lisense_plate"]}',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                              maxLines: 2,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                );
              }
              else
                return Center(child: Text("No Cars Found!"));
            }else
              return Center(child: CircularProgressIndicator(
                color: Colors.amber,
              ));
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
         await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOrUpdateCar(
                screenTitle: TranslationConstants.addCar.t(context),
                carName: '',
                carBrand: '${TranslationConstants.carBrand.t(context)} *',
                vehicleId: '',
                carModel: '${TranslationConstants.carModel.t(context)} *',
                carLicencePlate: '',
                carBrandId: '',
                carModelId: '',
                image: Strings.imgUrlCar,
              ),
            ),
          );

         setState(() {
           print('---- : getCarList');
           _future = getCarList();
         });
        },
        label: Text(TranslationConstants.addCar.t(context)),
        icon: Icon(Icons.add_circle_rounded),
      ),
    );
  }
}
