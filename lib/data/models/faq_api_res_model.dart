/// status : 1
/// message : "Faq List"
/// response : [{"id":1,"question":"Test question","answer":"Test Answer","status":1,"expanded":true}]

class FaqApiResModel {
  FaqApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  FaqApiResModel.fromJson(dynamic json) {
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

/// id : 1
/// question : "Test question"
/// answer : "Test Answer"
/// status : 1
/// expanded : true

class Response {
  Response({
      int? id, 
      String? question, 
      String? answer, 
      int? status, 
      bool? expanded,}){
    _id = id;
    _question = question;
    _answer = answer;
    _status = status;
    _expanded = expanded;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
    _status = json['status'];
    _expanded = json['expanded'];
  }
  int? _id;
  String? _question;
  String? _answer;
  int? _status;
  bool? _expanded;

  int? get id => _id;
  String? get question => _question;
  String? get answer => _answer;
  int? get status => _status;
  bool? get expanded => _expanded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    map['status'] = _status;
    map['expanded'] = _expanded;
    return map;
  }

}