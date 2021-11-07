/// status : 1
/// message : "TopUp History List"
/// response : {"topup_history":[{"date":"02/11/21","time":"12:13","amount":"12 THB"},{"date":"02/11/21","time":"12:15","amount":"12 THB"},{"date":"04/11/21","time":"04:51","amount":"15000.00 THB"},{"date":"04/11/21","time":"05:01","amount":"5.00 THB"},{"date":"05/11/21","time":"10:01","amount":"1999 THB"},{"date":"05/11/21","time":"10:00","amount":"01.00 THB"},{"date":"05/11/21","time":"15:36","amount":"0 THB"},{"date":"05/11/21","time":"13:10","amount":"10.00 THB"},{"date":"06/11/21","time":"04:07","amount":"1.1 THB"},{"date":"06/11/21","time":"05:18","amount":"10 THB"},{"date":"06/11/21","time":"05:20","amount":"10 THB"},{"date":"06/11/21","time":"15:46","amount":"0 THB"},{"date":"06/11/21","time":"15:50","amount":"1.1 THB"},{"date":"06/11/21","time":"12:05","amount":"100 THB"},{"date":"07/11/21","time":"07:10","amount":"1.1 THB"},{"date":"07/11/21","time":"09:18","amount":"155 THB"}],"charging_history":[{"date":"07/11/21","time":"40","consume_charge":"3 kWh","price":"155 THB"},{"date":"07/11/21","time":"00:01:29","consume_charge":"0.11 kWh","price":"1.1 THB"},{"date":"06/11/21","time":"00:01:29","consume_charge":"0.11 kWh","price":"1.1 THB"},{"date":"06/11/21","time":"00:00:12","consume_charge":"0 kWh","price":"0 THB"},{"date":"06/11/21","time":"00:01:46","consume_charge":"0.11 kWh","price":"1.1 THB"},{"date":"05/11/21","time":"00:00:12","consume_charge":"0 kWh","price":"0 THB"},{"date":"20/10/21","time":"8","consume_charge":"1.2 kWh","price":"12 THB"},{"date":"15/10/21","time":"8","consume_charge":"1.2 kWh","price":"12 THB"}],"wallet":"917.8"}

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

/// topup_history : [{"date":"02/11/21","time":"12:13","amount":"12 THB"},{"date":"02/11/21","time":"12:15","amount":"12 THB"},{"date":"04/11/21","time":"04:51","amount":"15000.00 THB"},{"date":"04/11/21","time":"05:01","amount":"5.00 THB"},{"date":"05/11/21","time":"10:01","amount":"1999 THB"},{"date":"05/11/21","time":"10:00","amount":"01.00 THB"},{"date":"05/11/21","time":"15:36","amount":"0 THB"},{"date":"05/11/21","time":"13:10","amount":"10.00 THB"},{"date":"06/11/21","time":"04:07","amount":"1.1 THB"},{"date":"06/11/21","time":"05:18","amount":"10 THB"},{"date":"06/11/21","time":"05:20","amount":"10 THB"},{"date":"06/11/21","time":"15:46","amount":"0 THB"},{"date":"06/11/21","time":"15:50","amount":"1.1 THB"},{"date":"06/11/21","time":"12:05","amount":"100 THB"},{"date":"07/11/21","time":"07:10","amount":"1.1 THB"},{"date":"07/11/21","time":"09:18","amount":"155 THB"}]
/// charging_history : [{"date":"07/11/21","time":"40","consume_charge":"3 kWh","price":"155 THB"},{"date":"07/11/21","time":"00:01:29","consume_charge":"0.11 kWh","price":"1.1 THB"},{"date":"06/11/21","time":"00:01:29","consume_charge":"0.11 kWh","price":"1.1 THB"},{"date":"06/11/21","time":"00:00:12","consume_charge":"0 kWh","price":"0 THB"},{"date":"06/11/21","time":"00:01:46","consume_charge":"0.11 kWh","price":"1.1 THB"},{"date":"05/11/21","time":"00:00:12","consume_charge":"0 kWh","price":"0 THB"},{"date":"20/10/21","time":"8","consume_charge":"1.2 kWh","price":"12 THB"},{"date":"15/10/21","time":"8","consume_charge":"1.2 kWh","price":"12 THB"}]
/// wallet : "917.8"

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

/// date : "07/11/21"
/// time : "40"
/// consume_charge : "3 kWh"
/// price : "155 THB"

class Charging_history {
  Charging_history({
      String? date, 
      String? time, 
      String? consumeCharge, 
      String? price,}){
    _date = date;
    _time = time;
    _consumeCharge = consumeCharge;
    _price = price;
}

  Charging_history.fromJson(dynamic json) {
    _date = json['date'];
    _time = json['time'];
    _consumeCharge = json['consume_charge'];
    _price = json['price'];
  }
  String? _date;
  String? _time;
  String? _consumeCharge;
  String? _price;

  String? get date => _date;
  String? get time => _time;
  String? get consumeCharge => _consumeCharge;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['time'] = _time;
    map['consume_charge'] = _consumeCharge;
    map['price'] = _price;
    return map;
  }

}

/// date : "02/11/21"
/// time : "12:13"
/// amount : "12 THB"

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