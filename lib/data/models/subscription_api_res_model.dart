/// status : 1
/// message : "Vip Class Plans List"
/// response : [{"id":1,"membership_name":"VIP Sapphire","membership_price":"1999","charging_price":"8.5","stay_time_after_charge":"60","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/plan/sapphire-1637245548.jpg","description":null,"active_plan":0},{"id":2,"membership_name":"VIP Ruby","membership_price":"2999","charging_price":"7","stay_time_after_charge":"120","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/plan/ruby-1637245527.jpg","description":null,"active_plan":0},{"id":3,"membership_name":"VVIP Diamond","membership_price":"3999","charging_price":"6","stay_time_after_charge":"180","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/plan/diamond-1637245498.jpg","description":null,"active_plan":0}]

class SubscriptionApiResModel {
  SubscriptionApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  SubscriptionApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['response'] != null) {
      _response = [];
      json['response'].forEach((v) {
        _response?.add(Response.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Response>? _response;

  int? get status => _status;
  String? get message => _message;
  List<Response>? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_response != null) {
      map['response'] = _response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// membership_name : "VIP Sapphire"
/// membership_price : "1999"
/// charging_price : "8.5"
/// stay_time_after_charge : "60"
/// image : "https://mridayaitservices.com/demo/qcharge/public/uploads/plan/sapphire-1637245548.jpg"
/// description : null
/// active_plan : 0

class Response {
  Response({
      int? id, 
      String? membershipName, 
      String? membershipPrice, 
      String? chargingPrice, 
      String? stayTimeAfterCharge, 
      String? image, 
      dynamic description, 
      int? activePlan,}){
    _id = id;
    _membershipName = membershipName;
    _membershipPrice = membershipPrice;
    _chargingPrice = chargingPrice;
    _stayTimeAfterCharge = stayTimeAfterCharge;
    _image = image;
    _description = description;
    _activePlan = activePlan;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _membershipName = json['membership_name'];
    _membershipPrice = json['membership_price'];
    _chargingPrice = json['charging_price'];
    _stayTimeAfterCharge = json['stay_time_after_charge'];
    _image = json['image'];
    _description = json['description'];
    _activePlan = json['active_plan'];
  }
  int? _id;
  String? _membershipName;
  String? _membershipPrice;
  String? _chargingPrice;
  String? _stayTimeAfterCharge;
  String? _image;
  dynamic _description;
  int? _activePlan;

  int? get id => _id;
  String? get membershipName => _membershipName;
  String? get membershipPrice => _membershipPrice;
  String? get chargingPrice => _chargingPrice;
  String? get stayTimeAfterCharge => _stayTimeAfterCharge;
  String? get image => _image;
  dynamic get description => _description;
  int? get activePlan => _activePlan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['membership_name'] = _membershipName;
    map['membership_price'] = _membershipPrice;
    map['charging_price'] = _chargingPrice;
    map['stay_time_after_charge'] = _stayTimeAfterCharge;
    map['image'] = _image;
    map['description'] = _description;
    map['active_plan'] = _activePlan;
    return map;
  }

}