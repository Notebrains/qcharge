
class FirebaseTokenParams {
  final String deviceToken;
  final String userId;

  FirebaseTokenParams({
    required this.deviceToken, required this.userId,
  });

  Map<String, dynamic> toJson() => {
    'device_token': deviceToken,
    'user_id': userId,
  };
}
