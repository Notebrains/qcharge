/// status : 1
/// message : "Profile Details."
/// response : {"name":"Alamgir Alam","email":"alamgira@mridayaitservices.com","mobile":"9732508414","current_membership_plan":"Unavailable","vehicles":[{"vehicle_id":2,"brand":"Honda","model":"ABCD1234","car_name":"ABCD123","car_lisense_plate":"EFGH123456"},{"vehicle_id":12,"brand":"Honda","model":"ABCD1234","car_name":"SDXZ2222","car_lisense_plate":"ZASA1234"}]}

class ProfileApiResModel {
  ProfileApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  ProfileApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  int? _status;
  String? _message;
  Response? _response;

  int? get status => _status;
  String? get message => _message;
  Response? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    return map;
  }

}

/// name : "Alamgir Alam"
/// email : "alamgira@mridayaitservices.com"
/// mobile : "9732508414"
/// current_membership_plan : "Unavailable"
/// vehicles : [{"vehicle_id":2,"brand":"Honda","model":"ABCD1234","car_name":"ABCD123","car_lisense_plate":"EFGH123456"},{"vehicle_id":12,"brand":"Honda","model":"ABCD1234","car_name":"SDXZ2222","car_lisense_plate":"ZASA1234"}]

class Response {
  Response({
      String? name, 
      String? email, 
      String? mobile, 
      String? currentMembershipPlan, 
      List<Vehicles>? vehicles,}){
    _name = name;
    _email = email;
    _mobile = mobile;
    _currentMembershipPlan = currentMembershipPlan;
    _vehicles = vehicles;
}

  Response.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _currentMembershipPlan = json['current_membership_plan'];
    if (json['vehicles'] != null) {
      _vehicles = [];
      json['vehicles'].forEach((v) {
        _vehicles?.add(Vehicles.fromJson(v));
      });
    }
  }
  String? _name;
  String? _email;
  String? _mobile;
  String? _currentMembershipPlan;
  List<Vehicles>? _vehicles;

  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get currentMembershipPlan => _currentMembershipPlan;
  List<Vehicles>? get vehicles => _vehicles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['current_membership_plan'] = _currentMembershipPlan;
    if (_vehicles != null) {
      map['vehicles'] = _vehicles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// vehicle_id : 2
/// brand : "Honda"
/// model : "ABCD1234"
/// car_name : "ABCD123"
/// car_lisense_plate : "EFGH123456"

class Vehicles {
  Vehicles({
      int? vehicleId, 
      String? brand, 
      String? model, 
      String? carName, 
      String? carLisensePlate,}){
    _vehicleId = vehicleId;
    _brand = brand;
    _model = model;
    _carName = carName;
    _carLisensePlate = carLisensePlate;
}

  Vehicles.fromJson(dynamic json) {
    _vehicleId = json['vehicle_id'];
    _brand = json['brand'];
    _model = json['model'];
    _carName = json['car_name'];
    _carLisensePlate = json['car_lisense_plate'];
  }
  int? _vehicleId;
  String? _brand;
  String? _model;
  String? _carName;
  String? _carLisensePlate;

  int? get vehicleId => _vehicleId;
  String? get brand => _brand;
  String? get model => _model;
  String? get carName => _carName;
  String? get carLisensePlate => _carLisensePlate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicle_id'] = _vehicleId;
    map['brand'] = _brand;
    map['model'] = _model;
    map['car_name'] = _carName;
    map['car_lisense_plate'] = _carLisensePlate;
    return map;
  }

}