/// status : 1
/// message : "TopUp History List"
/// response : {"topup_history":[{"date":"19/10/21","time":"18:16","amount":"10"},{"date":"19/10/21","time":"18:16","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:18","amount":"10"},{"date":"19/10/21","time":"18:18","amount":"10"},{"date":"20/10/21","time":"02:49","amount":"10"},{"date":"20/10/21","time":"02:49","amount":"10"},{"date":"20/10/21","time":"02:50","amount":"10"},{"date":"20/10/21","time":"02:50","amount":"10"},{"date":"20/10/21","time":"02:52","amount":"10"},{"date":"20/10/21","time":"02:52","amount":"10"},{"date":"20/10/21","time":"02:54","amount":"10"},{"date":"20/10/21","time":"02:54","amount":"10"},{"date":"20/10/21","time":"11:29","amount":"10"},{"date":"20/10/21","time":"11:29","amount":"10"},{"date":"20/10/21","time":"11:29","amount":"20"},{"date":"25/10/21","time":"09:34","amount":"1999"},{"date":"25/10/21","time":"09:34","amount":"1999"},{"date":"25/10/21","time":"09:37","amount":"1999"},{"date":"25/10/21","time":"09:37","amount":"1999"},{"date":"25/10/21","time":"10:02","amount":"1999"},{"date":"25/10/21","time":"10:02","amount":"1999"},{"date":"25/10/21","time":"10:27","amount":"1999"},{"date":"25/10/21","time":"10:27","amount":"1999"},{"date":"25/10/21","time":"10:43","amount":"1999"},{"date":"25/10/21","time":"10:43","amount":"1999"},{"date":"25/10/21","time":"09:59","amount":"10"},{"date":"25/10/21","time":"09:59","amount":"10"},{"date":"25/10/21","time":"10:28","amount":"10"},{"date":"25/10/21","time":"10:28","amount":"10"},{"date":"25/10/21","time":"10:39","amount":"30"},{"date":"25/10/21","time":"10:39","amount":"30"},{"date":"25/10/21","time":"10:41","amount":"30"},{"date":"25/10/21","time":"10:41","amount":"30"},{"date":"25/10/21","time":"10:59","amount":"30"},{"date":"25/10/21","time":"10:59","amount":"30"},{"date":"25/10/21","time":"11:02","amount":"30"},{"date":"25/10/21","time":"11:05","amount":"10"},{"date":"25/10/21","time":"11:06","amount":"10"},{"date":"25/10/21","time":"11:08","amount":"10"},{"date":"25/10/21","time":"11:10","amount":"10"},{"date":"25/10/21","time":"11:11","amount":"12"},{"date":"25/10/21","time":"11:12","amount":"10"}],"charging_history":[{"date":"25/10/21","time":"11:12","price":"10"}],"wallet":"442"}

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

/// topup_history : [{"date":"19/10/21","time":"18:16","amount":"10"},{"date":"19/10/21","time":"18:16","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:17","amount":"10"},{"date":"19/10/21","time":"18:18","amount":"10"},{"date":"19/10/21","time":"18:18","amount":"10"},{"date":"20/10/21","time":"02:49","amount":"10"},{"date":"20/10/21","time":"02:49","amount":"10"},{"date":"20/10/21","time":"02:50","amount":"10"},{"date":"20/10/21","time":"02:50","amount":"10"},{"date":"20/10/21","time":"02:52","amount":"10"},{"date":"20/10/21","time":"02:52","amount":"10"},{"date":"20/10/21","time":"02:54","amount":"10"},{"date":"20/10/21","time":"02:54","amount":"10"},{"date":"20/10/21","time":"11:29","amount":"10"},{"date":"20/10/21","time":"11:29","amount":"10"},{"date":"20/10/21","time":"11:29","amount":"20"},{"date":"25/10/21","time":"09:34","amount":"1999"},{"date":"25/10/21","time":"09:34","amount":"1999"},{"date":"25/10/21","time":"09:37","amount":"1999"},{"date":"25/10/21","time":"09:37","amount":"1999"},{"date":"25/10/21","time":"10:02","amount":"1999"},{"date":"25/10/21","time":"10:02","amount":"1999"},{"date":"25/10/21","time":"10:27","amount":"1999"},{"date":"25/10/21","time":"10:27","amount":"1999"},{"date":"25/10/21","time":"10:43","amount":"1999"},{"date":"25/10/21","time":"10:43","amount":"1999"},{"date":"25/10/21","time":"09:59","amount":"10"},{"date":"25/10/21","time":"09:59","amount":"10"},{"date":"25/10/21","time":"10:28","amount":"10"},{"date":"25/10/21","time":"10:28","amount":"10"},{"date":"25/10/21","time":"10:39","amount":"30"},{"date":"25/10/21","time":"10:39","amount":"30"},{"date":"25/10/21","time":"10:41","amount":"30"},{"date":"25/10/21","time":"10:41","amount":"30"},{"date":"25/10/21","time":"10:59","amount":"30"},{"date":"25/10/21","time":"10:59","amount":"30"},{"date":"25/10/21","time":"11:02","amount":"30"},{"date":"25/10/21","time":"11:05","amount":"10"},{"date":"25/10/21","time":"11:06","amount":"10"},{"date":"25/10/21","time":"11:08","amount":"10"},{"date":"25/10/21","time":"11:10","amount":"10"},{"date":"25/10/21","time":"11:11","amount":"12"},{"date":"25/10/21","time":"11:12","amount":"10"}]
/// charging_history : [{"date":"25/10/21","time":"11:12","price":"10"}]
/// wallet : "442"

class Response {
  Response({
      List<Topup_history>? topupHistory, 
      List<Charging_history>? chargingHistory, 
      String? wallet,}){
    _topupHistory = topupHistory;
    _chargingHistory = chargingHistory;
    _wallet = wallet;
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
    _wallet = json['wallet'];
  }
  List<Topup_history>? _topupHistory;
  List<Charging_history>? _chargingHistory;
  String? _wallet;

  List<Topup_history>? get topupHistory => _topupHistory;
  List<Charging_history>? get chargingHistory => _chargingHistory;
  String? get wallet => _wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topupHistory != null) {
      map['topup_history'] = _topupHistory?.map((v) => v.toJson()).toList();
    }
    if (_chargingHistory != null) {
      map['charging_history'] = _chargingHistory?.map((v) => v.toJson()).toList();
    }
    map['wallet'] = _wallet;
    return map;
  }

}

/// date : "25/10/21"
/// time : "11:12"
/// price : "10"

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

/// date : "19/10/21"
/// time : "18:16"
/// amount : "10"

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