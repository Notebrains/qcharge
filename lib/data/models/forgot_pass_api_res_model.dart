/// password : ";F!83IKE"
/// status : 1
/// message : "Great! Password has send to your email."

class ForgotPassApiResModel {
  ForgotPassApiResModel({
      String? password, 
      int? status, 
      String? message,}){
    _password = password;
    _status = status;
    _message = message;
}

  ForgotPassApiResModel.fromJson(dynamic json) {
    _password = json['password'];
    _status = json['status'];
    _message = json['message'];
  }
  String? _password;
  int? _status;
  String? _message;

  String? get password => _password;
  int? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = _password;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}