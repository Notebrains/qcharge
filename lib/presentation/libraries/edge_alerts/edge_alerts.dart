library edge_alerts;

import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

import 'overlay_view.dart';

enum Gravity { top, bottom }

//how to use
//edgeAlert(context, title: 'Title', description: 'Description', gravity: Gravity.top);

void edgeAlert(
    BuildContext context, {
      String title = '',
      String description = '',
      Color? backgroundColor = AppColor.alert_color,
      int duration = 1,
      Gravity gravity = Gravity.top,
      IconData? icon,
    }) {
  OverlayView.createView(
    context,
    title: title,
    description: description,
    duration: duration,
    gravity: gravity,
    backgroundColor: backgroundColor,
    icon: icon,
  );
}