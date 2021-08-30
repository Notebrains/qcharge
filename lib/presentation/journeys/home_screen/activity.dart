import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';


class Activity extends StatelessWidget{
  final String screenTitle;

  const Activity({Key? key, required this.screenTitle}) : super(key: key);

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
                itemBuilder: (context, position) {
                  return Column(
                    children: [
                      cachedNetImgWithRadius(Strings.imgUrlMeeting, double.infinity, Sizes.dimen_70.h, 6),

                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 24),
                        child: Txt(txt: Strings.txt_lorem_ipsum_big, txtColor: Colors.white, txtSize: 13, fontWeight: FontWeight.normal,
                            padding: 0, onTap: (){}),
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