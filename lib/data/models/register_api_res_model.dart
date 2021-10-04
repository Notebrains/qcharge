/// status : 1
/// message : "User Data"
/// response : {"user_id":13,"name":"Imdadul Haque","email":"imdadsul@gmail.com","mobile":"7980363195s","access_token":"R1NCQVRMdlFRd0JXTFZESkI1bXRMWExWMGxIQjMxaFgzcWxNdHRTR2hkRzI5SHpIRjRROVFnQnpRN0xX61542cf613eb9"}

class RegisterApiResModel {
  RegisterApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  RegisterApiResModel.fromJson(dynamic json) {
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

/// user_id : 13
/// name : "Imdadul Haque"
/// email : "imdadsul@gmail.com"
/// mobile : "7980363195s"
/// access_token : "R1NCQVRMdlFRd0JXTFZESkI1bXRMWExWMGxIQjMxaFgzcWxNdHRTR2hkRzI5SHpIRjRROVFnQnpRN0xX61542cf613eb9"

class Response {
  Response({
      int? userId, 
      String? name, 
      String? email, 
      String? mobile, 
      String? accessToken,}){
    _userId = userId;
    _name = name;
    _email = email;
    _mobile = mobile;
    _accessToken = accessToken;
}

  Response.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _accessToken = json['access_token'];
  }
  int? _userId;
  String? _name;
  String? _email;
  String? _mobile;
  String? _accessToken;

  int? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['access_token'] = _accessToken;
    return map;
  }

}