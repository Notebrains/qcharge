import 'package:shared_preferences/shared_preferences.dart';
class MySharedPreferences {
SharedPreferences? _preferences;

void addApiToken(String apiToken) async {
  _preferences = await SharedPreferences.getInstance();
  bool temp = await _preferences!.setString("apiToken", apiToken);
}

Future<String?> getApiToken() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("apiToken")) {
    String? key = _preferences!.getString("apiToken");
    return key;
  }
  else
    return "";
}

void addStationId(int stationId)async{
  _preferences = await SharedPreferences.getInstance();
  bool temp = await _preferences!.setInt("stationId", stationId);
}

Future<int?> getStationId() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("stationId")) {
    int? key = _preferences!.getInt("stationId");
    return key;
  }
  else
    return 0;
}

void addChargerId(int chargerId)async{
  _preferences = await SharedPreferences.getInstance();
  bool temp = await _preferences!.setInt("chargerId", chargerId);
}

Future<int?> getChargerId() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("chargerId")) {
    int? key = _preferences!.getInt("chargerId");
    return key;
  }
  else
    return 0;
}

void addChargerData(String chargerData) async {
  _preferences = await SharedPreferences.getInstance();
  bool temp = await _preferences!.setString("chargerData", chargerData);
}

Future<String?> getChargerData() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("chargerData")) {
    String? key = _preferences!.getString("chargerData");
    return key;
  }
  else
    return "";
}

void addConnectorData(String connectorData) async {
  _preferences = await SharedPreferences.getInstance();
  bool temp = await _preferences!.setString("connectorData", connectorData);
}

Future<String?> getConnectorData() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("connectorData")) {
    String? key = _preferences!.getString("connectorData");
    return key;
  }
  else
    return "";
}

void addElapsedTime(String time) async {
  _preferences = await SharedPreferences.getInstance();
  bool temp = await _preferences!.setString("time", time);
}

Future<String?> getElapsedTime() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("time")) {
    String? key = _preferences!.getString("time");
    return key;
  }
  else
    return "";
}

void addTotalUnits(String units) async {
  _preferences = await SharedPreferences.getInstance();
  bool temp = await _preferences!.setString("units", units);
}

Future<String?> getTotalUnits() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("units")) {
    String? key = _preferences!.getString("units");
    return key;
  }
  else
    return "";
}

void addStartDateTime(String units) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("startDateTime", units);
}

Future<String?> getStartDateTime() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("startDateTime")) {
    String? key = _preferences!.getString("startDateTime");
    return key;
  }
  else
    return "";
}

void addCardNo(String cardNo) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("cardNo", cardNo);
}

Future<String?> getCardNo() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("cardNo")) {
    String? key = _preferences!.getString("cardNo");
    return key;
  }
  else
    return "";
}


void addCouponId(String cardNo) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("couponID", cardNo);
}

Future<String?> getCouponId() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("couponID")) {
    String? key = _preferences!.getString("couponID");
    return key;
  }
  else
    return "";
}


void addNormalCustomerChargingPrice(String cardNo) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("NormalCustomerChargingPrice", cardNo);
}

Future<String?> getNormalCustomerChargingPrice() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("NormalCustomerChargingPrice")) {
    String? key = _preferences!.getString("NormalCustomerChargingPrice");
    return key;
  }
  else
    return "";
}


void addNormalCustomerParkingPrice(String cardNo) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("NormalCustomerParkingPrice", cardNo);
}

Future<String?> getNormalCustomerParkingPrice() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("NormalCustomerParkingPrice")) {
    String? key = _preferences!.getString("NormalCustomerParkingPrice");
    return key;
  }
  else
    return "";
}

}