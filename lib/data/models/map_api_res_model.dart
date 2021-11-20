/// status : 1
/// message : "EV Stations List"
/// response : [{"station_id":74,"station_name":"POLYTECH","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"22/222 Pathum Thani","latitude":"13.978145","longitude":"100.678476","type":"Private","secure":"Private","numberOfCharger":2,"image":"","status":"1","charger_type":"AC"},{"station_id":75,"station_name":"PEARL Bangkok","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"PEARL Bangkok","latitude":"13.7783238","longitude":"100.5408155","type":"Public","secure":"Public","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":76,"station_name":"สิริ แอท สุขุมวิท คอนโดมิเนียม","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"สิริ แอท สุขุมวิท คอนโดมิเนียม","latitude":"13.7229735","longitude":"100.5777965","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":77,"station_name":"Ficus Lane","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"Ficus Lane","latitude":"13.713931","longitude":"100.5872342","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":78,"station_name":"333 Riverside","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"333 Riverside","latitude":"13.8068134","longitude":"100.5174109","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":79,"station_name":"โรงพยาบาลวิมุต : Vimut hospital","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"โรงพยาบาลวิมุต : Vimut hospital","latitude":"13.7886073","longitude":"100.5461087","type":"Public","secure":"Public","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":80,"station_name":"ดีคอนโด แคมปัส รีสอร์ท บางนา","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"ดีคอนโด แคมปัส รีสอร์ท บางนา","latitude":"13.6036282","longitude":"100.8447521","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":81,"station_name":"T-ONE BUILDING","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"T-ONE BUILDING","latitude":"13.7223496","longitude":"100.5782348","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":82,"station_name":"Millennium Residence Bangkok","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"Millennium Residence Bangkok","latitude":"13.7297181","longitude":"100.5605296","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":83,"station_name":"เดอะ ไลน์ จตุจักร - หมอชิต","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"เดอะ ไลน์ จตุจักร - หมอชิต","latitude":"13.8058542","longitude":"100.5543309","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":84,"station_name":"Klass Sarasin Rajdamri","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"Klass Sarasin Rajdamri","latitude":"13.7348919","longitude":"100.5388347","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":85,"station_name":"Klass Langsuan","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"Klass Langsuan","latitude":"13.7419362","longitude":"100.5420381","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"},{"station_id":86,"station_name":"The Room สุขุมวิท 69","owner":"POLYTECH","city":"","state":"","country":"","zipcode":"","address":"The Room สุขุมวิท 69","latitude":"13.714446","longitude":"100.5906502","type":"Private","secure":"Private","numberOfCharger":0,"image":"","status":"1","charger_type":"NONE"}]

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

/// station_id : 74
/// station_name : "POLYTECH"
/// owner : "POLYTECH"
/// city : ""
/// state : ""
/// country : ""
/// zipcode : ""
/// address : "22/222 Pathum Thani"
/// latitude : "13.978145"
/// longitude : "100.678476"
/// type : "Private"
/// secure : "Private"
/// numberOfCharger : 2
/// image : ""
/// status : "1"
/// charger_type : "AC"

class Response {
  Response({
      int? stationId, 
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
      String? secure, 
      int? numberOfCharger, 
      String? image, 
      String? status, 
      String? chargerType,}){
    _stationId = stationId;
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
    _secure = secure;
    _numberOfCharger = numberOfCharger;
    _image = image;
    _status = status;
    _chargerType = chargerType;
}

  Response.fromJson(dynamic json) {
    _stationId = json['station_id'];
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
    _secure = json['secure'];
    _numberOfCharger = json['numberOfCharger'];
    _image = json['image'];
    _status = json['status'];
    _chargerType = json['charger_type'];
  }
  int? _stationId;
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
  String? _secure;
  int? _numberOfCharger;
  String? _image;
  String? _status;
  String? _chargerType;

  int? get stationId => _stationId;
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
  String? get secure => _secure;
  int? get numberOfCharger => _numberOfCharger;
  String? get image => _image;
  String? get status => _status;
  String? get chargerType => _chargerType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_id'] = _stationId;
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
    map['secure'] = _secure;
    map['numberOfCharger'] = _numberOfCharger;
    map['image'] = _image;
    map['status'] = _status;
    map['charger_type'] = _chargerType;
    return map;
  }

}