/// status : 1
/// message : "Profile updated successfully."

class SubscriptionApiResModel {
  SubscriptionApiResModel({
      int? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  SubscriptionApiResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  int? _status;
  String? _message;

  int? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}