class AddUpdateCarParams {
  final String userID;
  final String brand;
  final String model;
  final String carName;
  final String carLicencePlate;
  final String vehicleId;
  final String type;
  final String image;

  AddUpdateCarParams({
    required this.userID,
    required this.brand,
    required this.model,
    required this.carName,
    required this.carLicencePlate,
    required this.vehicleId,
    required this.type,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userID,
    'brand': brand,
    'model': model,
    'car_name': carName,
    'car_lisense_plate': carLicencePlate,
    'vehicle_id': vehicleId,
    'type': type,
    'image': image,
  };
}
