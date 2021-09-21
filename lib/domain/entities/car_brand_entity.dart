import 'package:equatable/equatable.dart';

class CarBrandEntity extends Equatable {
  final int? brandId;
  final int? id;
  final String? name;
  final String? logo;
  final String? description;


  const CarBrandEntity({
    required this.brandId,
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
  });

  @override
  List<Object?> get props => [brandId, name, id];

/*  @override
  bool get stringify => true;

  factory CarBrandEntity.fromCarBrandEntity(
      CarBrandEntity entity) {
    return CarBrandEntity(
      id: entity.id,
      name: entity.name,
      image: entity.image,
      description: entity.description,
    );
  }*/
}
