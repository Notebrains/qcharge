import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qcharge_flutter/common/constants/strings.dart';

Widget cachedNetImgWithRadius(String url, double width, double height, double radius) => ClipRRect(
  borderRadius: BorderRadius.circular(radius),
  child: CachedNetworkImage(
    height: height,
    width: width,
    fit: BoxFit.cover,
    //placeholder: (context, url) => CircularProgressIndicator(),
    imageUrl: url,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Image.asset('assets/animations/gifs/loading_line.gif', width: 100, height: 100),
    errorWidget: (context, url, error) => Image.network(Strings.imgUrlNotFound),
  ),
);
