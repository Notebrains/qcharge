/// status : 1
/// message : "Home Banner List"
/// response : [{"title":"Banner1","status":1,"image":"https://mridayaitservices.com/demo/qcharge/public/uploads/banner/chair-1635146691.jpg"},{"title":"Banner2","status":1,"image":"https://mridayaitservices.com/demo/qcharge/public/uploads/banner/1-s-1635146923.png"}]

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

/// title : "Banner1"
/// status : 1
/// image : "https://mridayaitservices.com/demo/qcharge/public/uploads/banner/chair-1635146691.jpg"

class Response {
  Response({
      String? title, 
      int? status, 
      String? image,}){
    _title = title;
    _status = status;
    _image = image;
}

  Response.fromJson(dynamic json) {
    _title = json['title'];
    _status = json['status'];
    _image = json['image'];
  }
  String? _title;
  int? _status;
  String? _image;

  String? get title => _title;
  int? get status => _status;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['status'] = _status;
    map['image'] = _image;
    return map;
  }

}