/// status : 1
/// message : "Charging Billing Data"
/// response : {"start_date":"07-09-2021","end_date":"07-09-2021","total_billing":20,"payment_flag":0,"history":[{"date":"07-09-2021","start_time":"06:27 PM","duration":"1 Hours","unit":"2.50 KWH","price":"20"}]}

class BillApiResModel {
  BillApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  BillApiResModel.fromJson(dynamic json) {
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

/// start_date : "07-09-2021"
/// end_date : "07-09-2021"
/// total_billing : 20
/// payment_flag : 0
/// history : [{"date":"07-09-2021","start_time":"06:27 PM","duration":"1 Hours","unit":"2.50 KWH","price":"20"}]

class Response {
  Response({
      String? startDate, 
      String? endDate,
    String? totalBilling,
      int? paymentFlag, 
      List<History>? history,}){
    _startDate = startDate;
    _endDate = endDate;
    _totalBilling = totalBilling;
    _paymentFlag = paymentFlag;
    _history = history;
}

  Response.fromJson(dynamic json) {
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _totalBilling = json['total_billing'];
    _paymentFlag = json['payment_flag'];
    if (json['history'] != null) {
      _history = [];
      json['history'].forEach((v) {
        _history?.add(History.fromJson(v));
      });
    }
  }
  String? _startDate;
  String? _endDate;
  String? _totalBilling;
  int? _paymentFlag;
  List<History>? _history;

  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get totalBilling => _totalBilling;
  int? get paymentFlag => _paymentFlag;
  List<History>? get history => _history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['total_billing'] = _totalBilling;
    map['payment_flag'] = _paymentFlag;
    if (_history != null) {
      map['history'] = _history?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "07-09-2021"
/// start_time : "06:27 PM"
/// duration : "1 Hours"
/// unit : "2.50 KWH"
/// price : "20"

class History {
  History({
      String? date, 
      String? startTime, 
      String? duration, 
      String? unit, 
      String? price,}){
    _date = date;
    _startTime = startTime;
    _duration = duration;
    _unit = unit;
    _price = price;
}

  History.fromJson(dynamic json) {
    _date = json['date'];
    _startTime = json['start_time'];
    _duration = json['duration'];
    _unit = json['unit'];
    _price = json['price'];
  }
  String? _date;
  String? _startTime;
  String? _duration;
  String? _unit;
  String? _price;

  String? get date => _date;
  String? get startTime => _startTime;
  String? get duration => _duration;
  String? get unit => _unit;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['start_time'] = _startTime;
    map['duration'] = _duration;
    map['unit'] = _unit;
    map['price'] = _price;
    return map;
  }

}