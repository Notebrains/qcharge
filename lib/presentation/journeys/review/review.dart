import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/common/constants/route_constants.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';
import 'package:qcharge_flutter/presentation/libraries/star_rating.dart';
import 'package:qcharge_flutter/presentation/widgets/appbar_back_cart.dart';
import 'package:qcharge_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';

class Review extends StatelessWidget {
  static const String routeName = '/review';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBarIcBackCart(context, 'Reviews'),
      body: buildUi(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteList.add_review);
        },
        child: Icon(Icons.add, color: Colors.white, size: 30,),
        backgroundColor: Colors.amber.shade600,
        tooltip: 'Pressed',
        elevation: 5,
        splashColor: Colors.grey,
      ),
    );
  }

  Widget buildUi() {
    return Column(
      children: [
        /*FadeInDown(
          child: Container(
            height: 125,
            width: double.maxFinite,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.grey[300]),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BounceInDown(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '4.0',
                      style: TextStyle( fontSize: 30, color: Colors.black54),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 8),
                  child: StarRating(
                    rating: 4.5,
                    color: Colors.amber,
                    iconSize: 25,
                  ),
                ),

                Text(
                  'Based on 20 reviews',
                  style: TextStyle( fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),*/

        Expanded(
          child: FadeInUpBig(
            child: Container(
              margin: EdgeInsets.only(bottom: 12, top: 8),
              //color: Colors.white,
              child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5, bottom: 3),
                                child: cachedNetImgWithRadius(Strings.imgUrlTestSupplyProduct, 60,
                                    60, 3),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 5, 5, 0),
                                    child: Text(
                                      'Product Name',
                                      style: TextStyle( fontSize: 14, color: Colors.black87, letterSpacing: 0.5),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 3, 8, 0),
                                        child: StarRating(
                                          rating: 4.0,
                                          color: Colors.amber,
                                          iconSize: 20,
                                          onRatingChanged: (double rating) {  },
                                        ),
                                      ),

                                      Text(
                                        '4',
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 12, left: 3),
                            child: Text(
                              Strings.txt_review,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
                            ),
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' Restaurant Name',
                                style: TextStyle( fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54),
                              ),

                              Text(
                                '25 jan, 2021',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(top: 8, right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(color: Colors.grey.shade400),
                                    ),
                                    alignment: Alignment.center,
                                    child: Txt(
                                      txt: 'Edit',
                                      txtColor: Colors.black,
                                      txtSize: 14,
                                      fontWeight: FontWeight.normal,
                                      padding: 3,
                                      onTap:  (){},
                                    ),
                                  ),
                                  onTap: () {

                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(top: 8, left: 4,),
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent.withOpacity(0.1),
                                      border: Border.all(color: Colors.grey.shade400),
                                    ),
                                    alignment: Alignment.center,
                                    child: Txt(
                                      txt: 'Delete',
                                      txtColor: Colors.black,
                                      txtSize: 14,
                                      fontWeight: FontWeight.normal,
                                      padding: 3,
                                      onTap:  (){},
                                    ),
                                  ),
                                  onTap: () {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
