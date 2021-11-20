import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';

Widget cachedNetImage(String url) => CachedNetworkImage(
  fit: BoxFit.cover,
  //placeholder: (context, url) => CircularProgressIndicator(),
  imageUrl: url,
  progressIndicatorBuilder: (context, url, downloadProgress) =>
      Lottie.asset('assets/animations/lottiefiles/3_line_loading.json', width: 100, height: 100),
  errorWidget: (context, url, error) => Image.network(Strings.imgUrlNotFound, fit: BoxFit.cover),

);