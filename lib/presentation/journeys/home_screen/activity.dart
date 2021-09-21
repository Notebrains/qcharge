import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/common_fun.dart';
import 'package:qcharge_flutter/data/models/home_card_api_res_model.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';


class Activity extends StatelessWidget{
  final String screenTitle;
  final HomeCardApiResModel model;

  const Activity({Key? key, required this.screenTitle, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, screenTitle),
      body: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Padding(
                padding: const EdgeInsets.only(left: 3, bottom:  12),
                child: Txt(txt: 'Activity', txtColor: Colors.white, txtSize: 20, fontWeight: FontWeight.bold, padding: 0, onTap: (){}),
              ),*/

            Expanded(
              child: ListView.builder(
                itemCount: model.response!.length,
                itemBuilder: (context, position) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cachedNetImgWithRadius(model.response![position].image!, double.infinity, Sizes.dimen_70.h, 6),

                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 24),
                        child: Text(
                          parseHtmlString(model.response![position].body!),
                          style: TextStyle(fontSize: 13, color: AppColor.app_txt_white),
                          maxLines: 4,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}