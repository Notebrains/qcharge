/// status : 1
/// message : "Promo Code List"
/// response : [{"id":1,"title":"Test Promo","coupon_code":"ABC123","discount_type":"Flat","amount":"15"},{"id":2,"title":"Test Promo1","coupon_code":"QSAWE1234","discount_type":"Percentage","amount":"20"},{"id":3,"title":"Coupon","coupon_code":"CPN5478","discount_type":"Flat","amount":"30"}]

class CouponCodeApiResModel {
  CouponCodeApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  CouponCodeApiResModel.fromJson(dynamic json) {
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
/// title : "Test Promo"
/// coupon_code : "ABC123"
/// discount_type : "Flat"
/// amount : "15"

class Response {
  Response({
      int? id, 
      String? title, 
      String? couponCode, 
      String? discountType, 
      String? amount,}){
    _id = id;
    _title = title;
    _couponCode = couponCode;
    _discountType = discountType;
    _amount = amount;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _couponCode = json['coupon_code'];
    _discountType = json['discount_type'];
    _amount = json['amount'];
  }
  int? _id;
  String? _title;
  String? _couponCode;
  String? _discountType;
  String? _amount;

  int? get id => _id;
  String? get title => _title;
  String? get couponCode => _couponCode;
  String? get discountType => _discountType;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['coupon_code'] = _couponCode;
    map['discount_type'] = _discountType;
    map['amount'] = _amount;
    return map;
  }

}