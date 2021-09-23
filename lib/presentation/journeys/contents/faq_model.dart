import 'package:flutter/material.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  String description;
  Color colorsItem;
  String img;

  ItemModel({this.expanded: true, required this.headerItem, required this.description,required this.colorsItem, required this.img});
}