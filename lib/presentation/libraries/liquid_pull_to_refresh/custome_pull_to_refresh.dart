import 'package:flutter/material.dart';
import 'package:qcharge_flutter/presentation/themes/theme_color.dart';

import 'liquid_pull_to_refresh.dart';

Widget pullToRefresh(Widget widget ){
   return LiquidPullToRefresh(
    color: AppColor.grey,
    backgroundColor: AppColor.secondary_color,
    onRefresh: () async => widget,
    child: widget,
  );
}