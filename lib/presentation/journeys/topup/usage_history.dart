import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:qcharge_flutter/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/app_bar_home.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_txt_txt_row.dart';

class TopUpHistory extends StatefulWidget {
  @override
  _TopUpHistoryState createState() => _TopUpHistoryState();
}

class _TopUpHistoryState extends State<TopUpHistory> {
  bool isTopUpTabSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideInUp(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 25),
                  child: Txt(txt: 'USAGE HISTORY', txtColor: Colors.white, txtSize: 14,
                    fontWeight: FontWeight.bold, padding: 0, onTap: (){},
                  ),
                ),

                Container(
                  height: 60,
                  width: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(top: 12, bottom: 25),
                  child: Txt(txt: 'July 2021', txtColor: Colors.white, txtSize: 14,
                    fontWeight: FontWeight.bold, padding: 0, onTap: (){},
                  ),
                ),
              ],
            ),

            Container(
                height: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isTopUpTabSelected? Colors.grey.shade700 : AppColor.grey,
                            ),
                            margin: const EdgeInsets.only(bottom: 25),
                            child: Txt(txt: 'TOP UP History', txtColor: Colors.white, txtSize: 16,
                              fontWeight: FontWeight.bold, padding: 0, onTap: (){
                                setState(() {
                                  isTopUpTabSelected = true;
                                });
                              },
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isTopUpTabSelected? AppColor.grey : Colors.grey.shade700,
                            ),
                            margin: const EdgeInsets.only(bottom: 25),
                            child: Txt(txt: 'Charging History', txtColor: Colors.white, txtSize: 16,
                              fontWeight: FontWeight.bold, padding: 0, onTap: (){
                                setState(() {
                                  isTopUpTabSelected = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TxtTxtTxtRow(text1: '  Date:', text2: '    Time:', text3: 'Amount:', size: 14, fontWeight: FontWeight.bold,),
                    ),


                    Expanded(
                      child: ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, position) {
                          return TxtTxtTxtRow(text1: '20/07/21', text2: '10:30', text3: '300 THB ', size: 12,
                            fontWeight: FontWeight.normal,
                          );
                        },
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
