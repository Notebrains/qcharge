
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';

/// brand_id : 1
/// name : "Honda"
/// logo : "https://mridayaitservices.com/demo/qcharge/public/uploads/brand/logo1-1630665779.png"

class CarBrandModelResponse extends CarBrandEntity{
  final int? brandId;
  final int? id;
  final String? name;
  final String? logo;
  final String? description;

  CarBrandModelResponse({
    this.brandId,
    this.id,
    this.name,
    this.logo,
    this.description,
  }): super(
    brandId : brandId,
    id : id,
    name : name,
    logo : logo,
    description : description,
  );

  factory CarBrandModelResponse.fromJson(dynamic json) {
    return CarBrandModelResponse(
      brandId : json['brand_id'],
      id : json['id'],
      name : json['name'],
      logo : json['logo'],
      description : json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['brand_id'] = brandId;
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    map['description'] = description;
    return map;
  }

}