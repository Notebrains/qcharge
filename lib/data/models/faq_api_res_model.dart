/// status : 1
/// message : "Activity List"
/// response : [{"id":1,"slug":"activity","title":"Activity","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/activity/home_screen_6-1632390538.png","body":"<p><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.</p>","status":1}]

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
/// slug : "activity"
/// title : "Activity"
/// image : "https://mridayaitservices.com/demo/qcharge/public/uploads/activity/home_screen_6-1632390538.png"
/// body : "<p><strong>Lorem Ipsum</strong>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.</p>"
/// status : 1

class Response {
  Response({
      int? id, 
      String? slug, 
      String? title, 
      String? image, 
      String? body, 
      int? status,}){
    _id = id;
    _slug = slug;
    _title = title;
    _image = image;
    _body = body;
    _status = status;
}

  Response.fromJson(dynamic json) {
    _id = json['id'];
    _slug = json['slug'];
    _title = json['title'];
    _image = json['image'];
    _body = json['body'];
    _status = json['status'];
  }
  int? _id;
  String? _slug;
  String? _title;
  String? _image;
  String? _body;
  int? _status;

  int? get id => _id;
  String? get slug => _slug;
  String? get title => _title;
  String? get image => _image;
  String? get body => _body;
  int? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['slug'] = _slug;
    map['title'] = _title;
    map['image'] = _image;
    map['body'] = _body;
    map['status'] = _status;
    return map;
  }

}