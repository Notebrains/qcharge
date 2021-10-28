/// status : 1
/// message : "Wallet Recharged Successfully"
/// wallet : "460"

class WalletRechargeApiRes {
  WalletRechargeApiRes({
      int? status, 
      String? message, 
      String? wallet,}){
    _status = status;
    _message = message;
    _wallet = wallet;
}

  WalletRechargeApiRes.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _wallet = json['wallet'];
  }
  int? _status;
  String? _message;
  String? _wallet;

  int? get status => _status;
  String? get message => _message;
  String? get wallet => _wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['wallet'] = _wallet;
    return map;
  }

}