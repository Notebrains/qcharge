import 'dart:convert';

/// ippPeriod : ""
/// ippInterestType : ""
/// ippInterestRate : ""
/// ippMerchantAbsorbRate : ""
/// paidChannel : ""
/// paidAgent : ""
/// paymentChannel : ""
/// backendInvoice : ""
/// issuerCountry : ""
/// bankName : ""
/// subMerchantList : {"subMerchant":[]}
/// version : ""
/// timeStamp : ""
/// respCode : "99"
/// merchantID : ""
/// subMerchantID : ""
/// pan : ""
/// amt : ""
/// uniqueTransactionCode : ""
/// tranRef : ""
/// approvalCode : ""
/// refNumber : ""
/// eci : ""
/// paymentScheme : ""
/// processBy : ""
/// dateTime : ""
/// status : "F"
/// raw : ""
/// failReason : "Invalid security code length"
/// userDefined1 : ""
/// userDefined2 : ""
/// userDefined3 : ""
/// userDefined4 : ""
/// userDefined5 : ""
/// storeCardUniqueID : ""
/// recurringUniqueID : ""
/// hashValue : ""

class CcPpPaymentResultResModel {
  CcPpPaymentResultResModel({
      String? ippPeriod, 
      String? ippInterestType, 
      String? ippInterestRate, 
      String? ippMerchantAbsorbRate, 
      String? paidChannel, 
      String? paidAgent, 
      String? paymentChannel, 
      String? backendInvoice, 
      String? issuerCountry, 
      String? bankName, 
      SubMerchantList? subMerchantList, 
      String? version, 
      String? timeStamp, 
      String? respCode, 
      String? merchantID, 
      String? subMerchantID, 
      String? pan, 
      String? amt, 
      String? uniqueTransactionCode, 
      String? tranRef, 
      String? approvalCode, 
      String? refNumber, 
      String? eci, 
      String? paymentScheme, 
      String? processBy, 
      String? dateTime, 
      String? status, 
      String? raw, 
      String? failReason, 
      String? userDefined1, 
      String? userDefined2, 
      String? userDefined3, 
      String? userDefined4, 
      String? userDefined5, 
      String? storeCardUniqueID, 
      String? recurringUniqueID, 
      String? hashValue,}){
    _ippPeriod = ippPeriod;
    _ippInterestType = ippInterestType;
    _ippInterestRate = ippInterestRate;
    _ippMerchantAbsorbRate = ippMerchantAbsorbRate;
    _paidChannel = paidChannel;
    _paidAgent = paidAgent;
    _paymentChannel = paymentChannel;
    _backendInvoice = backendInvoice;
    _issuerCountry = issuerCountry;
    _bankName = bankName;
    _subMerchantList = subMerchantList;
    _version = version;
    _timeStamp = timeStamp;
    _respCode = respCode;
    _merchantID = merchantID;
    _subMerchantID = subMerchantID;
    _pan = pan;
    _amt = amt;
    _uniqueTransactionCode = uniqueTransactionCode;
    _tranRef = tranRef;
    _approvalCode = approvalCode;
    _refNumber = refNumber;
    _eci = eci;
    _paymentScheme = paymentScheme;
    _processBy = processBy;
    _dateTime = dateTime;
    _status = status;
    _raw = raw;
    _failReason = failReason;
    _userDefined1 = userDefined1;
    _userDefined2 = userDefined2;
    _userDefined3 = userDefined3;
    _userDefined4 = userDefined4;
    _userDefined5 = userDefined5;
    _storeCardUniqueID = storeCardUniqueID;
    _recurringUniqueID = recurringUniqueID;
    _hashValue = hashValue;
}

  CcPpPaymentResultResModel.fromJson(dynamic json) {
    _ippPeriod = json['ippPeriod'];
    _ippInterestType = json['ippInterestType'];
    _ippInterestRate = json['ippInterestRate'];
    _ippMerchantAbsorbRate = json['ippMerchantAbsorbRate'];
    _paidChannel = json['paidChannel'];
    _paidAgent = json['paidAgent'];
    _paymentChannel = json['paymentChannel'];
    _backendInvoice = json['backendInvoice'];
    _issuerCountry = json['issuerCountry'];
    _bankName = json['bankName'];
    _subMerchantList = json['subMerchantList'];
    _version = json['version'];
    _timeStamp = json['timeStamp'];
    _respCode = json['respCode'];
    _merchantID = json['merchantID'];
    _subMerchantID = json['subMerchantID'];
    _pan = json['pan'];
    _amt = json['amt'];
    _uniqueTransactionCode = json['uniqueTransactionCode'];
    _tranRef = json['tranRef'];
    _approvalCode = json['approvalCode'];
    _refNumber = json['refNumber'];
    _eci = json['eci'];
    _paymentScheme = json['paymentScheme'];
    _processBy = json['processBy'];
    _dateTime = json['dateTime'];
    _status = json['status'];
    _raw = json['raw'];
    _failReason = json['failReason'];
    _userDefined1 = json['userDefined1'];
    _userDefined2 = json['userDefined2'];
    _userDefined3 = json['userDefined3'];
    _userDefined4 = json['userDefined4'];
    _userDefined5 = json['userDefined5'];
    _storeCardUniqueID = json['storeCardUniqueID'];
    _recurringUniqueID = json['recurringUniqueID'];
    _hashValue = json['hashValue'];
  }
  String? _ippPeriod;
  String? _ippInterestType;
  String? _ippInterestRate;
  String? _ippMerchantAbsorbRate;
  String? _paidChannel;
  String? _paidAgent;
  String? _paymentChannel;
  String? _backendInvoice;
  String? _issuerCountry;
  String? _bankName;
  SubMerchantList? _subMerchantList;
  String? _version;
  String? _timeStamp;
  String? _respCode;
  String? _merchantID;
  String? _subMerchantID;
  String? _pan;
  String? _amt;
  String? _uniqueTransactionCode;
  String? _tranRef;
  String? _approvalCode;
  String? _refNumber;
  String? _eci;
  String? _paymentScheme;
  String? _processBy;
  String? _dateTime;
  String? _status;
  String? _raw;
  String? _failReason;
  String? _userDefined1;
  String? _userDefined2;
  String? _userDefined3;
  String? _userDefined4;
  String? _userDefined5;
  String? _storeCardUniqueID;
  String? _recurringUniqueID;
  String? _hashValue;

  String? get ippPeriod => _ippPeriod;
  String? get ippInterestType => _ippInterestType;
  String? get ippInterestRate => _ippInterestRate;
  String? get ippMerchantAbsorbRate => _ippMerchantAbsorbRate;
  String? get paidChannel => _paidChannel;
  String? get paidAgent => _paidAgent;
  String? get paymentChannel => _paymentChannel;
  String? get backendInvoice => _backendInvoice;
  String? get issuerCountry => _issuerCountry;
  String? get bankName => _bankName;
  SubMerchantList? get subMerchantList => _subMerchantList;
  String? get version => _version;
  String? get timeStamp => _timeStamp;
  String? get respCode => _respCode;
  String? get merchantID => _merchantID;
  String? get subMerchantID => _subMerchantID;
  String? get pan => _pan;
  String? get amt => _amt;
  String? get uniqueTransactionCode => _uniqueTransactionCode;
  String? get tranRef => _tranRef;
  String? get approvalCode => _approvalCode;
  String? get refNumber => _refNumber;
  String? get eci => _eci;
  String? get paymentScheme => _paymentScheme;
  String? get processBy => _processBy;
  String? get dateTime => _dateTime;
  String? get status => _status;
  String? get raw => _raw;
  String? get failReason => _failReason;
  String? get userDefined1 => _userDefined1;
  String? get userDefined2 => _userDefined2;
  String? get userDefined3 => _userDefined3;
  String? get userDefined4 => _userDefined4;
  String? get userDefined5 => _userDefined5;
  String? get storeCardUniqueID => _storeCardUniqueID;
  String? get recurringUniqueID => _recurringUniqueID;
  String? get hashValue => _hashValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ippPeriod'] = _ippPeriod;
    map['ippInterestType'] = _ippInterestType;
    map['ippInterestRate'] = _ippInterestRate;
    map['ippMerchantAbsorbRate'] = _ippMerchantAbsorbRate;
    map['paidChannel'] = _paidChannel;
    map['paidAgent'] = _paidAgent;
    map['paymentChannel'] = _paymentChannel;
    map['backendInvoice'] = _backendInvoice;
    map['issuerCountry'] = _issuerCountry;
    map['bankName'] = _bankName;
    map['subMerchantList'] = _subMerchantList;
    map['version'] = _version;
    map['timeStamp'] = _timeStamp;
    map['respCode'] = _respCode;
    map['merchantID'] = _merchantID;
    map['subMerchantID'] = _subMerchantID;
    map['pan'] = _pan;
    map['amt'] = _amt;
    map['uniqueTransactionCode'] = _uniqueTransactionCode;
    map['tranRef'] = _tranRef;
    map['approvalCode'] = _approvalCode;
    map['refNumber'] = _refNumber;
    map['eci'] = _eci;
    map['paymentScheme'] = _paymentScheme;
    map['processBy'] = _processBy;
    map['dateTime'] = _dateTime;
    map['status'] = _status;
    map['raw'] = _raw;
    map['failReason'] = _failReason;
    map['userDefined1'] = _userDefined1;
    map['userDefined2'] = _userDefined2;
    map['userDefined3'] = _userDefined3;
    map['userDefined4'] = _userDefined4;
    map['userDefined5'] = _userDefined5;
    map['storeCardUniqueID'] = _storeCardUniqueID;
    map['recurringUniqueID'] = _recurringUniqueID;
    map['hashValue'] = _hashValue;
    return map;
  }

}

class SubMerchantList {
  SubMerchantList({
    this.subMerchant,
  });

  List<SubMerchant>? subMerchant = [];

  factory SubMerchantList.fromJson(String str) => SubMerchantList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubMerchantList.fromMap(Map<String, dynamic> json) => SubMerchantList(
    subMerchant: json["subMerchant"] == null
        ? null
        : List<SubMerchant>.from(json["subMerchant"].map((x) => SubMerchant.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "subMerchant": subMerchant == null ? null : List<SubMerchant>.from(subMerchant?.map((x) => x.toMap()) ?? []),
  };
}

class SubMerchant {
  SubMerchant({
    this.merchantId,
    this.uniqueTransactionCode,
    this.amount,
    this.amountDouble,
    this.desc,
  });

  String? merchantId;
  String? uniqueTransactionCode;
  String? amount;
  double? amountDouble = 0.0;
  String? desc;

  factory SubMerchant.fromJson(String str) => SubMerchant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubMerchant.fromMap(Map<String, dynamic> json) => SubMerchant(
    merchantId: json["merchantID"] == null ? null : json["merchantID"],
    uniqueTransactionCode: json["uniqueTransactionCode"] == null ? null : json["uniqueTransactionCode"],
    amount: json["amount"] == null ? null : json["amount"],
    amountDouble: json["amountDouble"] == null ? null : json["amountDouble"],
    desc: json["desc"] == null ? null : json["desc"],
  );

  Map<String, dynamic> toMap() => {
    "merchantID": merchantId == null ? null : merchantId,
    "uniqueTransactionCode": uniqueTransactionCode == null ? null : uniqueTransactionCode,
    "amount": amount == null ? null : amount,
    "amountDouble": amountDouble == null ? null : amountDouble,
    "desc": desc == null ? null : desc,
  };
}