/// status : 1
/// message : "EV Stations Details"
/// response : {"station_name":"โรงพยาบาลวิมุต : Vimut hospital","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"โรงพยาบาลวิมุต : Vimut hospital","latitude":"13.7886073","longitude":"100.5461087","type":"","space_type":"","secure":"Private","numberOfCharger":"0","image":"","description":"","status":1,"charging_status":1}

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

/// station_name : "โรงพยาบาลวิมุต : Vimut hospital"
/// owner : "POLYTECH"
/// city : ""
/// state : ""
/// country : ""
/// zipcode : ""
/// address : "โรงพยาบาลวิมุต : Vimut hospital"
/// latitude : "13.7886073"
/// longitude : "100.5461087"
/// type : ""
/// space_type : ""
/// secure : "Private"
/// numberOfCharger : "0"
/// image : ""
/// description : ""
/// status : 1
/// charging_status : 1

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
      int? chargingStatus,}){
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
    _chargingStatus = chargingStatus;
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
    _chargingStatus = json['charging_status'];
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
  int? _chargingStatus;

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
  int? get chargingStatus => _chargingStatus;

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
    map['charging_status'] = _chargingStatus;
    return map;
  }

}