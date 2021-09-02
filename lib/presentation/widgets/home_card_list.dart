import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/size_constants.dart';
import 'package:qcharge_flutter/common/extensions/size_extensions.dart';
import 'txt.dart';

class HomeCardList extends StatelessWidget{
  final String title;
  final String img;
  final Function onTap;

  const HomeCardList({Key? key,  required this.title,  required this.img,  required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: Sizes.dimen_120.w,
        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFEFE07D), Color(0xFF846E28), ]
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(3, 3),
            )
          ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Txt(txt: title, txtColor: Colors.black, txtSize: 14, fontWeight: FontWeight.bold,
                padding: 0, onTap: () {},
              ),
            ),

            Container(
              width: 25,
              height: 25,
              margin: EdgeInsets.only(left: 8),
              child: FloatingActionButton(
                heroTag: '8',
                mini: true,
                onPressed: () {
                  // Navigator.of(context).pushNamed(RouteList.add_review);
                },
                child: Icon(Icons.arrow_forward, color: Colors.white, size: 18,),
                backgroundColor: Colors.black,
                tooltip: 'Pressed',
                elevation: 0,
                splashColor: Colors.grey,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                img,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 60,
              ),
            ),

          ],
        ),
      ),
      onTap: () {
        onTap();
        //Navigator.of(context).pushNamed(RouteList.product_details);
      },
    );
  }
}