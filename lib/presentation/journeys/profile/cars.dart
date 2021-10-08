import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/data/models/profile_api_res_model.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';

import 'add_cars.dart';

class Cars extends StatefulWidget {
  final List<Vehicles> carList;

  const Cars({Key? key, required this.carList}) : super(key: key);

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, TranslationConstants.myCar.t(context)),
      body: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
        child: Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: widget.carList.length,
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
                            //placeholder: (context, url) => CircularProgressIndicator(),
                            imageUrl: Strings.imgUrlCar,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Lottie.asset('assets/animations/lottiefiles/loading-dots.json', width: 100, height: 100),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                              child: Text(
                                widget.carList[position].brand!.toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey.shade700),
                                maxLines: 4,
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
                                    color: Colors.grey.shade700,
                                  ),

                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddOrUpdateCar(
                                          screenTitle: TranslationConstants.updateCar.t(context),
                                          carName: widget.carList[position].carName!,
                                          carBrand: widget.carList[position].brand!,
                                          carChargingType: 'Ac',
                                          carModel: widget.carList[position].model!,
                                          carLicencePlate: widget.carList[position].carLisensePlate!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6, right: 12),
                                    child: Icon(
                                      Icons.delete_rounded,
                                      size: 22,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.carList.removeAt(position);
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
                              '${TranslationConstants.name.t(context)}: ${widget.carList[position].carName!}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 6),
                            child: Text(
                              '${TranslationConstants.brand.t(context)}: ${widget.carList[position].brand!}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 6),
                            child: Text(
                              '${TranslationConstants.model.t(context)}: ${widget.carList[position].model!}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 6),
                            child: Text(
                              '${TranslationConstants.licencePlate.t(context)}: ${widget.carList[position].carLisensePlate!}',
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
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOrUpdateCar(
                screenTitle: TranslationConstants.addCar.t(context),
                carName: '${TranslationConstants.name.t(context)} *',
                carBrand: '${TranslationConstants.carBrand.t(context)} *',
                carChargingType: 'Car Charging Type *',
                carModel: '${TranslationConstants.carModel.t(context)} *',
                carLicencePlate: '${TranslationConstants.carLicencePlate.t(context)} *',
              ),
            ),
          );
        },
        label: Text(TranslationConstants.addCar.t(context)),
        icon: Icon(Icons.add_circle_rounded),
      ),
    );
  }
}
