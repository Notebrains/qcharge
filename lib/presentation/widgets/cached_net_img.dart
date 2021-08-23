import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetImage(String url) => CachedNetworkImage(
  fit: BoxFit.cover,
  //placeholder: (context, url) => CircularProgressIndicator(),
  imageUrl: url,
  progressIndicatorBuilder: (context, url, downloadProgress) =>
      Image.asset('assets/animations/gifs/loading_line.gif', width: 50, height: 100),
  errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined),
);