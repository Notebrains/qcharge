/// status : 1
/// message : "Profile Details."
/// response : {"name":"Alamgir Alam","email":"alamgira@mridayaitservices.com","mobile":"9732508414","current_membership_plan":"Unavailable"}

class ProfileApiResModel {
  ProfileApiResModel({
      int? status, 
      String? message, 
      Response? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  ProfileApiResModel.fromJson(dynamic json) {
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

/// name : "Alamgir Alam"
/// email : "alamgira@mridayaitservices.com"
/// mobile : "9732508414"
/// current_membership_plan : "Unavailable"

class Response {
  Response({
      String? name, 
      String? email, 
      String? mobile, 
      String? currentMembershipPlan,}){
    _name = name;
    _email = email;
    _mobile = mobile;
    _currentMembershipPlan = currentMembershipPlan;
}

  Response.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _currentMembershipPlan = json['current_membership_plan'];
  }
  String? _name;
  String? _email;
  String? _mobile;
  String? _currentMembershipPlan;

  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get currentMembershipPlan => _currentMembershipPlan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['current_membership_plan'] = _currentMembershipPlan;
    return map;
  }

}