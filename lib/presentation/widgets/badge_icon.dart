import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  BadgeIcon(
      { required this.icon,
        this.badgeCount = 0,
        this.showIfZero = false,
        this.badgeColor = Colors.red,
        required this.onTap,
        TextStyle? badgeTextStyle})
      : this.badgeTextStyle = badgeTextStyle ??
      TextStyle(
        color: Colors.white,
        fontSize: 8,
      );
  final Widget icon;
  final int badgeCount;
  final bool showIfZero;
  final Color badgeColor;
  final Function onTap;
  final TextStyle badgeTextStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: new Stack(children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: icon,
            )),
        if (badgeCount > 0 || showIfZero) badge(badgeCount),
      ]),
    );
  }

  Widget badge(int count) => Positioned(
    right: 10,
    top: 8,
    child: new Container(
      padding: EdgeInsets.only(top: 2),
      decoration: new BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8.5),
      ),
      constraints: BoxConstraints(
        minWidth: 15,
        minHeight: 15,
      ),
      child: Text(
        count.toString(),
        style: new TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}