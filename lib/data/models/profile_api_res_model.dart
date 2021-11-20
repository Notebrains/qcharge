/// status : 1
/// message : "Profile Details."
/// response : {"name":"Imdadul Haque","email":"imdadulhaque.bt@gmail.com","mobile":"0909564636","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/user/img_1635783069.jpg","wallet":"9436.02","collect_point":"0","current_membership_plan":"Unavailable","current_membership_plan_price":"","user_level":"Lv 1 Copper","due_billing":"1,052.42","payment_flag":0,"normal_customer_charging_price":"10","normal_customer_parking_price":"100","normal_customer_stay_time_after_charge":"5","vehicles":[{"vehicle_id":1,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Audi","car_lisense_plate":"Audi005x","image":""}]}

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

/// name : "Imdadul Haque"
/// email : "imdadulhaque.bt@gmail.com"
/// mobile : "0909564636"
/// image : "https://mridayaitservices.com/demo/qcharge/public/uploads/user/img_1635783069.jpg"
/// wallet : "9436.02"
/// collect_point : "0"
/// current_membership_plan : "Unavailable"
/// current_membership_plan_price : ""
/// user_level : "Lv 1 Copper"
/// due_billing : "1,052.42"
/// payment_flag : 0
/// normal_customer_charging_price : "10"
/// normal_customer_parking_price : "100"
/// normal_customer_stay_time_after_charge : "5"
/// vehicles : [{"vehicle_id":1,"brand_id":1,"model_id":1,"brand":"Honda","model":"ABCD1234","car_name":"Audi","car_lisense_plate":"Audi005x","image":""}]

class Response {
  Response({
      String? name, 
      String? email, 
      String? mobile, 
      String? image, 
      String? wallet, 
      String? collectPoint, 
      String? currentMembershipPlan, 
      String? currentMembershipPlanPrice, 
      String? userLevel, 
      String? dueBilling, 
      int? paymentFlag, 
      String? normalCustomerChargingPrice, 
      String? normalCustomerParkingPrice, 
      String? normalCustomerStayTimeAfterCharge, 
      List<Vehicles>? vehicles,}){
    _name = name;
    _email = email;
    _mobile = mobile;
    _image = image;
    _wallet = wallet;
    _collectPoint = collectPoint;
    _currentMembershipPlan = currentMembershipPlan;
    _currentMembershipPlanPrice = currentMembershipPlanPrice;
    _userLevel = userLevel;
    _dueBilling = dueBilling;
    _paymentFlag = paymentFlag;
    _normalCustomerChargingPrice = normalCustomerChargingPrice;
    _normalCustomerParkingPrice = normalCustomerParkingPrice;
    _normalCustomerStayTimeAfterCharge = normalCustomerStayTimeAfterCharge;
    _vehicles = vehicles;
}

  Response.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _wallet = json['wallet'];
    _collectPoint = json['collect_point'];
    _currentMembershipPlan = json['current_membership_plan'];
    _currentMembershipPlanPrice = json['current_membership_plan_price'];
    _userLevel = json['user_level'];
    _dueBilling = json['due_billing'];
    _paymentFlag = json['payment_flag'];
    _normalCustomerChargingPrice = json['normal_customer_charging_price'];
    _normalCustomerParkingPrice = json['normal_customer_parking_price'];
    _normalCustomerStayTimeAfterCharge = json['normal_customer_stay_time_after_charge'];
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
  String? _image;
  String? _wallet;
  String? _collectPoint;
  String? _currentMembershipPlan;
  String? _currentMembershipPlanPrice;
  String? _userLevel;
  String? _dueBilling;
  int? _paymentFlag;
  String? _normalCustomerChargingPrice;
  String? _normalCustomerParkingPrice;
  String? _normalCustomerStayTimeAfterCharge;
  List<Vehicles>? _vehicles;

  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get wallet => _wallet;
  String? get collectPoint => _collectPoint;
  String? get currentMembershipPlan => _currentMembershipPlan;
  String? get currentMembershipPlanPrice => _currentMembershipPlanPrice;
  String? get userLevel => _userLevel;
  String? get dueBilling => _dueBilling;
  int? get paymentFlag => _paymentFlag;
  String? get normalCustomerChargingPrice => _normalCustomerChargingPrice;
  String? get normalCustomerParkingPrice => _normalCustomerParkingPrice;
  String? get normalCustomerStayTimeAfterCharge => _normalCustomerStayTimeAfterCharge;
  List<Vehicles>? get vehicles => _vehicles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['wallet'] = _wallet;
    map['collect_point'] = _collectPoint;
    map['current_membership_plan'] = _currentMembershipPlan;
    map['current_membership_plan_price'] = _currentMembershipPlanPrice;
    map['user_level'] = _userLevel;
    map['due_billing'] = _dueBilling;
    map['payment_flag'] = _paymentFlag;
    map['normal_customer_charging_price'] = _normalCustomerChargingPrice;
    map['normal_customer_parking_price'] = _normalCustomerParkingPrice;
    map['normal_customer_stay_time_after_charge'] = _normalCustomerStayTimeAfterCharge;
    if (_vehicles != null) {
      map['vehicles'] = _vehicles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// vehicle_id : 1
/// brand_id : 1
/// model_id : 1
/// brand : "Honda"
/// model : "ABCD1234"
/// car_name : "Audi"
/// car_lisense_plate : "Audi005x"
/// image : ""

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