
class VerifyResParams {
  final String mobile;
  final String otp;

  VerifyResParams({
    required this.mobile, required this.otp,
  });

  Map<String, dynamic> toJson() => {
    'mobile': mobile,
    'otp': otp,
  };
}
