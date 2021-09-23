/// status : "1"
/// message : "Mobile verify successfully."

class FaqApiResModel {
  FaqApiResModel({
      String? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  FaqApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  String? _status;
  String? _message;

  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}