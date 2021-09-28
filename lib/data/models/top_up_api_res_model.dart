/// status : 1
/// message : "TopUp History List"
/// response : {"topup_history":[{"date":"09/09/21","time":"09:07","amount":"100"},{"date":"09/09/21","time":"09:07","amount":"100"},{"date":"09/09/21","time":"13:11","amount":"100"}],"charging_history":[{"date":"06/09/21","time":"00:00","price":"1000"}]}

class TopUpApiResModel {
  TopUpApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  TopUpApiResModel.fromJson(dynamic json) {
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

/// topup_history : [{"date":"09/09/21","time":"09:07","amount":"100"},{"date":"09/09/21","time":"09:07","amount":"100"},{"date":"09/09/21","time":"13:11","amount":"100"}]
/// charging_history : [{"date":"06/09/21","time":"00:00","price":"1000"}]

class Response {
  Response({
      List<Topup_history>? topupHistory, 
      List<Charging_history>? chargingHistory,}){
    _topupHistory = topupHistory;
    _chargingHistory = chargingHistory;
}

  Response.fromJson(dynamic json) {
    if (json['topup_history'] != null) {
      _topupHistory = [];
      json['topup_history'].forEach((v) {
        _topupHistory?.add(Topup_history.fromJson(v));
      });
    }
    if (json['charging_history'] != null) {
      _chargingHistory = [];
      json['charging_history'].forEach((v) {
        _chargingHistory?.add(Charging_history.fromJson(v));
      });
    }
  }
  List<Topup_history>? _topupHistory;
  List<Charging_history>? _chargingHistory;

  List<Topup_history>? get topupHistory => _topupHistory;
  List<Charging_history>? get chargingHistory => _chargingHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topupHistory != null) {
      map['topup_history'] = _topupHistory?.map((v) => v.toJson()).toList();
    }
    if (_chargingHistory != null) {
      map['charging_history'] = _chargingHistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "06/09/21"
/// time : "00:00"
/// price : "1000"

class Charging_history {
  Charging_history({
      String? date, 
      String? time, 
      String? price,}){
    _date = date;
    _time = time;
    _price = price;
}

  Charging_history.fromJson(dynamic json) {
    _date = json['date'];
    _time = json['time'];
    _price = json['price'];
  }
  String? _date;
  String? _time;
  String? _price;

  String? get date => _date;
  String? get time => _time;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['time'] = _time;
    map['price'] = _price;
    return map;
  }

}

/// date : "09/09/21"
/// time : "09:07"
/// amount : "100"

class Topup_history {
  Topup_history({
      String? date, 
      String? time, 
      String? amount,}){
    _date = date;
    _time = time;
    _amount = amount;
}

  Topup_history.fromJson(dynamic json) {
    _date = json['date'];
    _time = json['time'];
    _amount = json['amount'];
  }
  String? _date;
  String? _time;
  String? _amount;

  String? get date => _date;
  String? get time => _time;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['time'] = _time;
    map['amount'] = _amount;
    return map;
  }

}