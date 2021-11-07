import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

class NoDataFound extends StatelessWidget{
  final String txt;
  final Function onRefresh;
  const NoDataFound({Key? key,required this.txt, required this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50, right: 80),
            child: Lottie.asset('assets/animations/lottiefiles/lottie-empty.json', fit: BoxFit.cover, width: 200, height: 200),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 80, top: 5),
            child: Text(txt,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.border, fontSize: 20, fontWeight: FontWeight.normal, wordSpacing: 0),
            ),
          ),

          /*InkWell(
            child: Container(
              height: 35,
              width: 150,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
              decoration: BoxDecoration(
                color: AppColor.border,
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Text('Refresh',
                style: TextStyle( fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
              ),
            ),
            onTap: (){
              onRefresh();
            },
          ),*/
        ],
      ),
    );
  }

}