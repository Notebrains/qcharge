import 'package:shared_preferences/shared_preferences.dart';
class MySharedPreferences {
SharedPreferences? _preferences;

void addApiToken(String apiToken) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("apiToken", apiToken);
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
  await _preferences!.setInt("stationId", stationId);
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
  await _preferences!.setInt("chargerId", chargerId);
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

void addLeftConnectorId(String id)async{
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("LeftConnectorId", id);
}

Future<String?> getLeftConnectorId() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("LeftConnectorId")) {
    String? key = _preferences!.getString("LeftConnectorId");
    return key;
  }
  else
    return '';
}

void addRightConnectorId(String id)async{
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("RightConnectorId", id);
}

Future<String?> getRightConnectorId() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("RightConnectorId")) {
    String? key = _preferences!.getString("RightConnectorId");
    return key;
  }
  else
    return '';
}

void addChargerData(String chargerData) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("chargerData", chargerData);
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
  await _preferences!.setString("time", time);
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

void addEndTime(String endTime) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("endTime", endTime);
}

Future<String?> getEndTime() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("endTime")) {
    String? key = _preferences!.getString("endTime");
    return key;
  }
  else
    return "";
}

void addTotalUnits(String units) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("units", units);
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

void addUserChargingStatus(String userChargingStatus) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("userChargingStatus", userChargingStatus);
}

Future<String?> getUserChargingStatus() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("userChargingStatus")) {
    String? key = _preferences!.getString("userChargingStatus");
    return key;
  }
  else
    return "";
}


void addUserChargingFinishStatus(String userChargingFinishStatus) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("userChargingFinishStatus", userChargingFinishStatus);
}

Future<String?> getUserChargingFinishStatus() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("userChargingFinishStatus")) {
    String? key = _preferences!.getString("userChargingFinishStatus");
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


void addUserName(String userName) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("UserName", userName);
}

Future<String?> getUserName() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("UserName")) {
    String? key = _preferences!.getString("UserName");
    return key;
  }
  else
    return "";
}


void addUserMob(String userMob) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("UserMob", userMob);
}

Future<String?> getUserMob() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("UserMob")) {
    String? key = _preferences!.getString("UserMob");
    return key;
  }
  else
    return "";
}

void addStopWatchTime(String disposeTimerTime) async {
  _preferences = await SharedPreferences.getInstance();
  await _preferences!.setString("disposeTimerTime", disposeTimerTime);
}

Future<String?> getStopWatchTime() async {
  _preferences = await SharedPreferences.getInstance();
  if(_preferences!.containsKey("disposeTimerTime")) {
    String? key = _preferences!.getString("disposeTimerTime");
    return key;
  }
  else
    return "00:00:00";
}

}