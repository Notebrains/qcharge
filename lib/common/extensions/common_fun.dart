import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:qcharge_flutter/presentation/libraries/flutter_toast.dart';

String getFirstWordFromText(String txt) {
  return (txt + " ").split(" ")[0]; //add " " to string to be sure there is something to split
}

void showToast(BuildContext context, String message) {
  Toast.show(
    message,
    context,
    duration: Toast.lengthLong,
    gravity: Toast.bottom,
    backgroundColor: Colors.black87.withOpacity(0.5),
    textStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      shadows: [
        Shadow(color: Colors.white),
      ],
    ),
  );
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

String getBase64FormatFile(String path) {
  File file = File(path);
  List<int> fileInByte = file.readAsBytesSync();
  String fileInBase64 = base64Encode(fileInByte);
  return fileInBase64;
}

String convertStrToDoubleStr(String value) => value.isNotEmpty ? double.parse(value).toStringAsFixed(2).toString() : '0';

String convertStrToDoubleStrWithZeroDecimal(String value) =>
    value.isNotEmpty ? double.parse(value).toStringAsFixed(0).toString() : '0';

String formatDateForTopUp(DateTime date) => new DateFormat("yyyy-MM").format(date);

String formatDateForServer(DateTime date) => new DateFormat("yyyy-MM-dd").format(date);
