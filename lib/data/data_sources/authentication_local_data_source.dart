

import 'package:hive/hive.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
  Future<String?> getSessionId();
  Future<void> saveWalletBalance(String amount);
  Future<String?> getWalletBalance();
  Future<void> deleteSessionId();
  Future<String?> getUserDuePaymentFlag();
  Future<void> saveUserDuePaymentFlag(String status);
  Future<String?> getUserSubscriptionStatus();
  Future<void> saveUserSubscriptionStatus(String status);
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {
  @override
  Future<void> deleteSessionId() async {
    print('delete session - local');
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.delete('session_id');
  }


  @override
  Future<String?> getSessionId() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.get('session_id');
  }

  @override
  Future<void> saveSessionId(String sessionId) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.put('session_id', sessionId);
  }

  @override
  Future<String?> getWalletBalance() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.get('wallet_balance');
  }

  @override
  Future<void> saveWalletBalance(String amount) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.put('wallet_balance', amount);
  }

  @override
  Future<String?> getUserDuePaymentFlag() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.get('duePaymentStatus');
  }

  @override
  Future<void> saveUserDuePaymentFlag(String status) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.put('duePaymentStatus', status);
  }

  @override
  Future<String?> getUserSubscriptionStatus() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.get('subsStatus');
  }

  @override
  Future<void> saveUserSubscriptionStatus(String status) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.put('subsStatus', status);
  }
}
