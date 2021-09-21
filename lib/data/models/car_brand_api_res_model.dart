import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';

import 'car_brand_model.dart';

/// status : 1
/// message : "Brand List"
/// response : [{"brand_id":1,"name":"Honda","logo":"https://mridayaitservices.com/demo/qcharge/public/uploads/brand/logo1-1630665779.png"}]

class CarBrandApiResModel{
  int? _status;
  String? _message;
  List<CarBrandModelResponse>? _response;

  int? get status => _status;
  String? get message => _message;
  List<CarBrandModelResponse>? get response => _response;

  CarBrandApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['response'] != null) {
      _response = [];
      json['response'].forEach((v) {
        _response?.add(CarBrandModelResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_response != null) {
      map['response'] = _response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
