/// station : {"stationId":74,"name":"POLYTECH","owner":"POLYTECH","lat":"13.978145","lon":"100.678476","numberOfCharger":2,"images":null,"type":"Private","status":"1"}
/// charger : {"id":"7401","detail":{"name":"TH0321070053","brand":"Schneider Electric","model":"MONOBLOCK","connector":[{"connectorId":1,"type":"Socket T2","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"Socket T2","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}],"images":null},"statusId":1,"status":"Ready","location":{"station":"POLYTECH","lat":"13.978145","lon":"100.678476"},"remark":"","lastUpdate":"2021-10-22 14:49:23.000"}
/// response : {"code":"S200","message":"Success"}

class QrScanApiResModel {
  QrScanApiResModel({
      Station? station, 
      Charger? charger, 
      Response? response,}){
    _station = station;
    _charger = charger;
    _response = response;
}

  QrScanApiResModel.fromJson(dynamic json) {
    _station = json['station'] != null ? Station.fromJson(json['station']) : null;
    _charger = json['charger'] != null ? Charger.fromJson(json['charger']) : null;
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  Station? _station;
  Charger? _charger;
  Response? _response;

  Station? get station => _station;
  Charger? get charger => _charger;
  Response? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_station != null) {
      map['station'] = _station?.toJson();
    }
    if (_charger != null) {
      map['charger'] = _charger?.toJson();
    }
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    return map;
  }

}

/// code : "S200"
/// message : "Success"

class Response {
  Response({
      String? code, 
      String? message,}){
    _code = code;
    _message = message;
}

  Response.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
  }
  String? _code;
  String? _message;

  String? get code => _code;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }

}

/// id : "7401"
/// detail : {"name":"TH0321070053","brand":"Schneider Electric","model":"MONOBLOCK","connector":[{"connectorId":1,"type":"Socket T2","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"Socket T2","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}],"images":null}
/// statusId : 1
/// status : "Ready"
/// location : {"station":"POLYTECH","lat":"13.978145","lon":"100.678476"}
/// remark : ""
/// lastUpdate : "2021-10-22 14:49:23.000"

class Charger {
  Charger({
      String? id, 
      Detail? detail, 
      int? statusId, 
      String? status, 
      Location? location, 
      String? remark, 
      String? lastUpdate,}){
    _id = id;
    _detail = detail;
    _statusId = statusId;
    _status = status;
    _location = location;
    _remark = remark;
    _lastUpdate = lastUpdate;
}

  Charger.fromJson(dynamic json) {
    _id = json['id'];
    _detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    _statusId = json['statusId'];
    _status = json['status'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _remark = json['remark'];
    _lastUpdate = json['lastUpdate'];
  }
  String? _id;
  Detail? _detail;
  int? _statusId;
  String? _status;
  Location? _location;
  String? _remark;
  String? _lastUpdate;

  String? get id => _id;
  Detail? get detail => _detail;
  int? get statusId => _statusId;
  String? get status => _status;
  Location? get location => _location;
  String? get remark => _remark;
  String? get lastUpdate => _lastUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_detail != null) {
      map['detail'] = _detail?.toJson();
    }
    map['statusId'] = _statusId;
    map['status'] = _status;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['remark'] = _remark;
    map['lastUpdate'] = _lastUpdate;
    return map;
  }

}

/// station : "POLYTECH"
/// lat : "13.978145"
/// lon : "100.678476"

class Location {
  Location({
      String? station, 
      String? lat, 
      String? lon,}){
    _station = station;
    _lat = lat;
    _lon = lon;
}

  Location.fromJson(dynamic json) {
    _station = json['station'];
    _lat = json['lat'];
    _lon = json['lon'];
  }
  String? _station;
  String? _lat;
  String? _lon;

  String? get station => _station;
  String? get lat => _lat;
  String? get lon => _lon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station'] = _station;
    map['lat'] = _lat;
    map['lon'] = _lon;
    return map;
  }

}

/// name : "TH0321070053"
/// brand : "Schneider Electric"
/// model : "MONOBLOCK"
/// connector : [{"connectorId":1,"type":"Socket T2","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"Socket T2","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}]
/// images : null

class Detail {
  Detail({
      String? name, 
      String? brand, 
      String? model, 
      List<Connector>? connector, 
      dynamic images,}){
    _name = name;
    _brand = brand;
    _model = model;
    _connector = connector;
    _images = images;
}

  Detail.fromJson(dynamic json) {
    _name = json['name'];
    _brand = json['brand'];
    _model = json['model'];
    if (json['connector'] != null) {
      _connector = [];
      json['connector'].forEach((v) {
        _connector?.add(Connector.fromJson(v));
      });
    }
    _images = json['images'];
  }
  String? _name;
  String? _brand;
  String? _model;
  List<Connector>? _connector;
  dynamic _images;

  String? get name => _name;
  String? get brand => _brand;
  String? get model => _model;
  List<Connector>? get connector => _connector;
  dynamic get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['brand'] = _brand;
    map['model'] = _model;
    if (_connector != null) {
      map['connector'] = _connector?.map((v) => v.toJson()).toList();
    }
    map['images'] = _images;
    return map;
  }

}

/// connectorId : 1
/// type : "Socket T2"
/// status : "1"
/// cardNo : "-"
/// startTime : "-"
/// meterValue : 0
/// etf : 0
/// images : null

class Connector {
  Connector({
      int? connectorId, 
      String? type, 
      String? status, 
      String? cardNo, 
      String? startTime, 
      int? meterValue, 
      int? etf, 
      dynamic images,}){
    _connectorId = connectorId;
    _type = type;
    _status = status;
    _cardNo = cardNo;
    _startTime = startTime;
    _meterValue = meterValue;
    _etf = etf;
    _images = images;
}

  Connector.fromJson(dynamic json) {
    _connectorId = json['connectorId'];
    _type = json['type'];
    _status = json['status'];
    _cardNo = json['cardNo'];
    _startTime = json['startTime'];
    _meterValue = json['meterValue'];
    _etf = json['etf'];
    _images = json['images'];
  }
  int? _connectorId;
  String? _type;
  String? _status;
  String? _cardNo;
  String? _startTime;
  int? _meterValue;
  int? _etf;
  dynamic _images;

  int? get connectorId => _connectorId;
  String? get type => _type;
  String? get status => _status;
  String? get cardNo => _cardNo;
  String? get startTime => _startTime;
  int? get meterValue => _meterValue;
  int? get etf => _etf;
  dynamic get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['connectorId'] = _connectorId;
    map['type'] = _type;
    map['status'] = _status;
    map['cardNo'] = _cardNo;
    map['startTime'] = _startTime;
    map['meterValue'] = _meterValue;
    map['etf'] = _etf;
    map['images'] = _images;
    return map;
  }

}

/// stationId : 74
/// name : "POLYTECH"
/// owner : "POLYTECH"
/// lat : "13.978145"
/// lon : "100.678476"
/// numberOfCharger : 2
/// images : null
/// type : "Private"
/// status : "1"

class Station {
  Station({
      int? stationId, 
      String? name, 
      String? owner, 
      String? lat, 
      String? lon, 
      int? numberOfCharger, 
      dynamic images, 
      String? type, 
      String? status,}){
    _stationId = stationId;
    _name = name;
    _owner = owner;
    _lat = lat;
    _lon = lon;
    _numberOfCharger = numberOfCharger;
    _images = images;
    _type = type;
    _status = status;
}

  Station.fromJson(dynamic json) {
    _stationId = json['stationId'];
    _name = json['name'];
    _owner = json['owner'];
    _lat = json['lat'];
    _lon = json['lon'];
    _numberOfCharger = json['numberOfCharger'];
    _images = json['images'];
    _type = json['type'];
    _status = json['status'];
  }
  int? _stationId;
  String? _name;
  String? _owner;
  String? _lat;
  String? _lon;
  int? _numberOfCharger;
  dynamic _images;
  String? _type;
  String? _status;

  int? get stationId => _stationId;
  String? get name => _name;
  String? get owner => _owner;
  String? get lat => _lat;
  String? get lon => _lon;
  int? get numberOfCharger => _numberOfCharger;
  dynamic get images => _images;
  String? get type => _type;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stationId'] = _stationId;
    map['name'] = _name;
    map['owner'] = _owner;
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['numberOfCharger'] = _numberOfCharger;
    map['images'] = _images;
    map['type'] = _type;
    map['status'] = _status;
    return map;
  }

}