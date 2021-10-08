/// status : 1
/// message : "Vip Class Plans List"
/// response : [{"id":1,"membership_name":"VIP 1","membership_price":"1500","charging_price":"4","stay_time_after_charge":"2","description":"test"},{"id":2,"membership_name":"VIP 2","membership_price":"3000","charging_price":"2","stay_time_after_charge":"5","description":"Test Check"}]

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
/// membership_name : "VIP 1"
/// membership_price : "1500"
/// charging_price : "4"
/// stay_time_after_charge : "2"
/// description : "test"

class Response {
  Response({
      int? id, 
      String? membershipName, 
      String? membershipPrice, 
      String? chargingPrice, 
      String? stayTimeAfterCharge, 
      String? description,}){
    _id = id;
    _membershipName = membershipName;
    _membershipPrice = membershipPrice;
    _chargingPrice = chargingPrice;
    _stayTimeAfterCharge = stayTimeAfterCharge;
    _description = description;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _membershipName = json['membership_name'];
    _membershipPrice = json['membership_price'];
    _chargingPrice = json['charging_price'];
    _stayTimeAfterCharge = json['stay_time_after_charge'];
    _description = json['description'];
  }
  int? _id;
  String? _membershipName;
  String? _membershipPrice;
  String? _chargingPrice;
  String? _stayTimeAfterCharge;
  String? _description;

  int? get id => _id;
  String? get membershipName => _membershipName;
  String? get membershipPrice => _membershipPrice;
  String? get chargingPrice => _chargingPrice;
  String? get stayTimeAfterCharge => _stayTimeAfterCharge;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['membership_name'] = _membershipName;
    map['membership_price'] = _membershipPrice;
    map['charging_price'] = _chargingPrice;
    map['stay_time_after_charge'] = _stayTimeAfterCharge;
    map['description'] = _description;
    return map;
  }

}