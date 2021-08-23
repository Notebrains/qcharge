import 'package:flutter/material.dart';
/*
How to use in flutter
DashedLine(
                    color: Colors.white.withOpacity(0.3),
                  )
*/
class DashedLine extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double paddingTop;
  final double paddingBottom;
  final Color color;

  const DashedLine(
      {this.height = 1, this.color = Colors.black, this.dashWidth = 5.0, this.paddingTop = 0.0, this.paddingBottom = 0.0});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Padding(
            padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
            child: Flex(
              children: List.generate(dashCount, (index) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color),
                  ),
                );
              }),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              direction: Axis.horizontal,
            ),
          );
        });
  }
}