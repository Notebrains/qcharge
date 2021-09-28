/// status : 1
/// message : "EV Stations List"
/// response : [{"station_id":1,"station_name":"Station 2","city":"Pune","state":"Maharashtra","country":"Thailand","zipcode":"700091","address":"Pune","latitude":"13.785699","longitude":"99.957632","type":"Ac","space_type":"Available","secure":"Public","image":"","description":"test1","status":1},{"station_id":2,"station_name":"Station 1","city":"Bangkok","state":"Maharashtra","country":"Thailand","zipcode":"700092","address":"Mumbai","latitude":"13.735455","longitude":"100.693212","type":"Ac","space_type":"Available","secure":"Public","image":"","description":"test","status":1},{"station_id":3,"station_name":"Station 3","city":"Nagpur","state":"Maharashtra","country":"Thailand","zipcode":"700058","address":"Nagpur","latitude":"14.184497","longitude":"100.622331","type":"Dc","space_type":"Unavailable","secure":"Private","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/stations/slide1-1630069229-1632827605.jpg","description":"test description","status":1}]

class MapApiResModel {
  MapApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  MapApiResModel.fromJson(dynamic json) {
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

/// station_id : 1
/// station_name : "Station 2"
/// city : "Pune"
/// state : "Maharashtra"
/// country : "Thailand"
/// zipcode : "700091"
/// address : "Pune"
/// latitude : "13.785699"
/// longitude : "99.957632"
/// type : "Ac"
/// space_type : "Available"
/// secure : "Public"
/// image : ""
/// description : "test1"
/// status : 1

class Response {
  Response({
      int? stationId, 
      String? stationName, 
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
      String? image, 
      String? description, 
      int? status,}){
    _stationId = stationId;
    _stationName = stationName;
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
    _image = image;
    _description = description;
    _status = status;
}

  Response.fromJson(dynamic json) {
    _stationId = json['station_id'];
    _stationName = json['station_name'];
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
    _image = json['image'];
    _description = json['description'];
    _status = json['status'];
  }
  int? _stationId;
  String? _stationName;
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
  String? _image;
  String? _description;
  int? _status;

  int? get stationId => _stationId;
  String? get stationName => _stationName;
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
  String? get image => _image;
  String? get description => _description;
  int? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_id'] = _stationId;
    map['station_name'] = _stationName;
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
    map['image'] = _image;
    map['description'] = _description;
    map['status'] = _status;
    return map;
  }

}