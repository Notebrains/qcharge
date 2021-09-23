/// status : 1
/// message : "Activity List"
/// response : [{"id":1,"slug":"activity","title":"Activity","image":"https://mridayaitservices.com/demo/qcharge/public/uploads/activity/slide1-1630069229.jpg","body":"<p>test description</p>","status":1}]

class HomeBannerApiResModel {
  HomeBannerApiResModel({
      int? status, 
      String? message, 
      List<Response>? response,}){
    _status = status;
    _message = message;
    _response = response;
}

  HomeBannerApiResModel.fromJson(dynamic json) {
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
/// image : "https://mridayaitservices.com/demo/qcharge/public/uploads/activity/slide1-1630069229.jpg"
/// body : "<p>test description</p>"
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