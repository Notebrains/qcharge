import 'package:dartz/dartz_streaming.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:qcharge_flutter/presentation/themes/theme_color.dart';
import 'package:qcharge_flutter/presentation/widgets/txt.dart';
import 'package:qcharge_flutter/presentation/widgets/txt_with_width.dart';

class PandaBarFabButton extends StatefulWidget {

  final double size;
  final VoidCallback? onTap;
  final List<Color>? colors;
  final Widget? icon;

  const PandaBarFabButton({
    Key? key,
    required this.size,
    required this.onTap,
    this.colors,
    this.icon,
  }) : super(key: key);

  @override
  _PandaBarFabButtonState createState() => _PandaBarFabButtonState();
}

class _PandaBarFabButtonState extends State<PandaBarFabButton> {
  bool _touched = false;

  @override
  Widget build(BuildContext context) {
    final _colors = widget.colors ??
        [
          AppColor.grey,
          AppColor.grey,
        ];

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: InkResponse(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap as void Function(),
        onHighlightChanged: (touched) {
          setState(() {
            _touched = touched;
          });
        },
        child: Container(
          width: _touched ? widget.size - 1 : widget.size,
          height: _touched ? widget.size - 1 : widget.size,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.text, width: 2),
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: _touched ? _colors : _colors.reversed.toList()),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(3, 3),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/pngs/scan_qr_for_filter_20_scan.png',
                width: 20,
                height: 20,
              ),

              TxtWithWidth(txt: 'QR Code', txtColor: AppColor.app_txt_white, txtSize: 11,
                  fontWeight: FontWeight.normal, width: double.maxFinite,)
            ],
          ),
        )
      ),
    );
  }
}