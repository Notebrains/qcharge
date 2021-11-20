/// status : 1
/// message : "EV Stations Details"
/// response : {"station_name":"POLYTECH","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"22/222 Pathum Thani","latitude":"13.978145","longitude":"100.678476","type":"","space_type":"","secure":"Private","numberOfCharger":"2","image":"","description":"","status":1,"chargers":[{"id":"7401","detail":{"name":"TH0321070053","brand":"Schneider Electric","model":"MONOBLOCK","connector":[{"connectorId":1,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}],"images":null},"statusId":1,"status":"Ready","location":{"station":"POLYTECH","lat":"13.978145","lon":"100.678476"},"remark":"","lastUpdate":"2021-11-11 22:49:33.000"},{"id":"7402","detail":{"name":"TH0321070051","brand":"Schneider Electric","model":"MONOBLOCK","connector":[{"connectorId":1,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}],"images":null},"statusId":1,"status":"Ready","location":{"station":"POLYTECH","lat":"13.978145","lon":"100.678476"},"remark":"","lastUpdate":"2021-10-28 22:15:49.000"}]}

class StationDetailsApiResModel {
  StationDetailsApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  StationDetailsApiResModel.fromJson(dynamic json) {
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

/// station_name : "POLYTECH"
/// owner : "POLYTECH"
/// city : ""
/// state : ""
/// country : ""
/// zipcode : ""
/// address : "22/222 Pathum Thani"
/// latitude : "13.978145"
/// longitude : "100.678476"
/// type : ""
/// space_type : ""
/// secure : "Private"
/// numberOfCharger : "2"
/// image : ""
/// description : ""
/// status : 1
/// chargers : [{"id":"7401","detail":{"name":"TH0321070053","brand":"Schneider Electric","model":"MONOBLOCK","connector":[{"connectorId":1,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}],"images":null},"statusId":1,"status":"Ready","location":{"station":"POLYTECH","lat":"13.978145","lon":"100.678476"},"remark":"","lastUpdate":"2021-11-11 22:49:33.000"},{"id":"7402","detail":{"name":"TH0321070051","brand":"Schneider Electric","model":"MONOBLOCK","connector":[{"connectorId":1,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}],"images":null},"statusId":1,"status":"Ready","location":{"station":"POLYTECH","lat":"13.978145","lon":"100.678476"},"remark":"","lastUpdate":"2021-10-28 22:15:49.000"}]

class Response {
  Response({
      String? stationName, 
      String? owner, 
      String? city, 
      String? state, 
      String? country, 
      String? zipcode, 
      String? address, 
      String? latitude, 
      String? longitude, 
      String? type, 
      String? spaceType, 
      String? secure, 
      String? numberOfCharger, 
      String? image, 
      String? description, 
      int? status, 
      List<Chargers>? chargers,}){
    _stationName = stationName;
    _owner = owner;
    _city = city;
    _state = state;
    _country = country;
    _zipcode = zipcode;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
    _type = type;
    _spaceType = spaceType;
    _secure = secure;
    _numberOfCharger = numberOfCharger;
    _image = image;
    _description = description;
    _status = status;
    _chargers = chargers;
}

  Response.fromJson(dynamic json) {
    _stationName = json['station_name'];
    _owner = json['owner'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _zipcode = json['zipcode'];
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _type = json['type'];
    _spaceType = json['space_type'];
    _secure = json['secure'];
    _numberOfCharger = json['numberOfCharger'];
    _image = json['image'];
    _description = json['description'];
    _status = json['status'];
    if (json['chargers'] != null) {
      _chargers = [];
      json['chargers'].forEach((v) {
        _chargers?.add(Chargers.fromJson(v));
      });
    }
  }
  String? _stationName;
  String? _owner;
  String? _city;
  String? _state;
  String? _country;
  String? _zipcode;
  String? _address;
  String? _latitude;
  String? _longitude;
  String? _type;
  String? _spaceType;
  String? _secure;
  String? _numberOfCharger;
  String? _image;
  String? _description;
  int? _status;
  List<Chargers>? _chargers;

  String? get stationName => _stationName;
  String? get owner => _owner;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get zipcode => _zipcode;
  String? get address => _address;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get type => _type;
  String? get spaceType => _spaceType;
  String? get secure => _secure;
  String? get numberOfCharger => _numberOfCharger;
  String? get image => _image;
  String? get description => _description;
  int? get status => _status;
  List<Chargers>? get chargers => _chargers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_name'] = _stationName;
    map['owner'] = _owner;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['zipcode'] = _zipcode;
    map['address'] = _address;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['type'] = _type;
    map['space_type'] = _spaceType;
    map['secure'] = _secure;
    map['numberOfCharger'] = _numberOfCharger;
    map['image'] = _image;
    map['description'] = _description;
    map['status'] = _status;
    if (_chargers != null) {
      map['chargers'] = _chargers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "7401"
/// detail : {"name":"TH0321070053","brand":"Schneider Electric","model":"MONOBLOCK","connector":[{"connectorId":1,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}],"images":null}
/// statusId : 1
/// status : "Ready"
/// location : {"station":"POLYTECH","lat":"13.978145","lon":"100.678476"}
/// remark : ""
/// lastUpdate : "2021-11-11 22:49:33.000"

class Chargers {
  Chargers({
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

  Chargers.fromJson(dynamic json) {
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
/// connector : [{"connectorId":1,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null},{"connectorId":2,"type":"AC Type2","kw":"22 kW","status":"1","cardNo":"-","startTime":"-","meterValue":0,"etf":0,"images":null}]
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
/// type : "AC Type2"
/// kw : "22 kW"
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
      String? kw, 
      String? status, 
      String? cardNo, 
      String? startTime, 
      int? meterValue, 
      int? etf, 
      dynamic images,}){
    _connectorId = connectorId;
    _type = type;
    _kw = kw;
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
    _kw = json['kw'];
    _status = json['status'];
    _cardNo = json['cardNo'];
    _startTime = json['startTime'];
    _meterValue = json['meterValue'];
    _etf = json['etf'];
    _images = json['images'];
  }
  int? _connectorId;
  String? _type;
  String? _kw;
  String? _status;
  String? _cardNo;
  String? _startTime;
  int? _meterValue;
  int? _etf;
  dynamic _images;

  int? get connectorId => _connectorId;
  String? get type => _type;
  String? get kw => _kw;
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
    map['kw'] = _kw;
    map['status'] = _status;
    map['cardNo'] = _cardNo;
    map['startTime'] = _startTime;
    map['meterValue'] = _meterValue;
    map['etf'] = _etf;
    map['images'] = _images;
    return map;
  }

}