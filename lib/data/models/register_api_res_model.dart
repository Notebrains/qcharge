/// user_id : 7
/// name : "Imdadul Haque"
/// email : "imdadul@gmail.com"
/// mobile : "7980363195"
/// access_token : "STA1cmdKZGVyOTdMRUVkUU9JZThneUtGOXVRYmd0Q0xYRWpscXZuRHZqZkNSUGg2eFBpM3R1QVFWVTE561360838c564c"

class RegisterApiResModel {
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

  RegisterApiResModel({
      int? userId, 
      String? name, 
      String? email, 
      String? mobile, 
      String? accessToken}){
    _userId = userId;
    _name = name;
    _email = email;
    _mobile = mobile;
    _accessToken = accessToken;
}

  RegisterApiResModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['access_token'] = _accessToken;
    return map;
  }

}