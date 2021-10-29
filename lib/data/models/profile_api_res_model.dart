/// status : 1
/// message : "Profile Details."
/// response : {"name":"Alamgir Alam","email":"alamgira@mridayaitservices.com","mobile":"9732508414","wallet":"570","collect_point":"50","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/user/img_1635240476.jpg","current_membership_plan":"Unavailable","current_membership_plan_price":"","due_billing":20,"payment_flag":0,"vehicles":[{"vehicle_id":18,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"ABCD123","car_lisense_plate":"EFG1234","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/vehicles/img_1634634846.jpg"},{"vehicle_id":19,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"SDXZ2222","car_lisense_plate":"ZASA1234","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/vehicles/img_1634635010.jpg"},{"vehicle_id":29,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Audi","car_lisense_plate":"Audi555","image":""},{"vehicle_id":39,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Holhag","car_lisense_plate":"kjsjdjjd","image":""},{"vehicle_id":40,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Holhag","car_lisense_plate":"kjsjdjjd","image":""}]}

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
/// wallet : "570"
/// collect_point : "50"
/// image : "https://mridayaitservices.com/demo/qcharge/public/uploads/user/img_1635240476.jpg"
/// current_membership_plan : "Unavailable"
/// current_membership_plan_price : ""
/// due_billing : 20
/// payment_flag : 0
/// vehicles : [{"vehicle_id":18,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"ABCD123","car_lisense_plate":"EFG1234","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/vehicles/img_1634634846.jpg"},{"vehicle_id":19,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"SDXZ2222","car_lisense_plate":"ZASA1234","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/vehicles/img_1634635010.jpg"},{"vehicle_id":29,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Audi","car_lisense_plate":"Audi555","image":""},{"vehicle_id":39,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Holhag","car_lisense_plate":"kjsjdjjd","image":""},{"vehicle_id":40,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Holhag","car_lisense_plate":"kjsjdjjd","image":""}]

class Response {
  Response({
      String? name, 
      String? email, 
      String? mobile, 
      String? wallet, 
      String? collectPoint, 
      String? image, 
      String? currentMembershipPlan, 
      String? currentMembershipPlanPrice, 
      int? dueBilling, 
      int? paymentFlag, 
      List<Vehicles>? vehicles,}){
    _name = name;
    _email = email;
    _mobile = mobile;
    _wallet = wallet;
    _collectPoint = collectPoint;
    _image = image;
    _currentMembershipPlan = currentMembershipPlan;
    _currentMembershipPlanPrice = currentMembershipPlanPrice;
    _dueBilling = dueBilling;
    _paymentFlag = paymentFlag;
    _vehicles = vehicles;
}

  Response.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _wallet = json['wallet'];
    _collectPoint = json['collect_point'];
    _image = json['image'];
    _currentMembershipPlan = json['current_membership_plan'];
    _currentMembershipPlanPrice = json['current_membership_plan_price'];
    _dueBilling = json['due_billing'];
    _paymentFlag = json['payment_flag'];
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
  String? _wallet;
  String? _collectPoint;
  String? _image;
  String? _currentMembershipPlan;
  String? _currentMembershipPlanPrice;
  int? _dueBilling;
  int? _paymentFlag;
  List<Vehicles>? _vehicles;

  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get wallet => _wallet;
  String? get collectPoint => _collectPoint;
  String? get image => _image;
  String? get currentMembershipPlan => _currentMembershipPlan;
  String? get currentMembershipPlanPrice => _currentMembershipPlanPrice;
  int? get dueBilling => _dueBilling;
  int? get paymentFlag => _paymentFlag;
  List<Vehicles>? get vehicles => _vehicles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['wallet'] = _wallet;
    map['collect_point'] = _collectPoint;
    map['image'] = _image;
    map['current_membership_plan'] = _currentMembershipPlan;
    map['current_membership_plan_price'] = _currentMembershipPlanPrice;
    map['due_billing'] = _dueBilling;
    map['payment_flag'] = _paymentFlag;
    if (_vehicles != null) {
      map['vehicles'] = _vehicles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// vehicle_id : 18
/// brand_id : 1
/// model_id : 1
/// brand : "Honda"
/// model : "ABCD1234"
/// car_name : "ABCD123"
/// car_lisense_plate : "EFG1234"
/// image : "https://mridayaitservices.com/demo/qcharge/public/uploads/vehicles/img_1634634846.jpg"

class Vehicles {
  Vehicles({
      int? vehicleId, 
      int? brandId, 
      int? modelId, 
      String? brand, 
      String? model, 
      String? carName, 
      String? carLisensePlate, 
      String? image,}){
    _vehicleId = vehicleId;
    _brandId = brandId;
    _modelId = modelId;
    _brand = brand;
    _model = model;
    _carName = carName;
    _carLisensePlate = carLisensePlate;
    _image = image;
}

  Vehicles.fromJson(dynamic json) {
    _vehicleId = json['vehicle_id'];
    _brandId = json['brand_id'];
    _modelId = json['model_id'];
    _brand = json['brand'];
    _model = json['model'];
    _carName = json['car_name'];
    _carLisensePlate = json['car_lisense_plate'];
    _image = json['image'];
  }
  int? _vehicleId;
  int? _brandId;
  int? _modelId;
  String? _brand;
  String? _model;
  String? _carName;
  String? _carLisensePlate;
  String? _image;

  int? get vehicleId => _vehicleId;
  int? get brandId => _brandId;
  int? get modelId => _modelId;
  String? get brand => _brand;
  String? get model => _model;
  String? get carName => _carName;
  String? get carLisensePlate => _carLisensePlate;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicle_id'] = _vehicleId;
    map['brand_id'] = _brandId;
    map['model_id'] = _modelId;
    map['brand'] = _brand;
    map['model'] = _model;
    map['car_name'] = _carName;
    map['car_lisense_plate'] = _carLisensePlate;
    map['image'] = _image;
    return map;
  }

}