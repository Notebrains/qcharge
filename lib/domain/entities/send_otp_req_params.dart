
class SendOtpReqParams {
  final String mobile;

  SendOtpReqParams({
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
    'mobile': mobile,
  };
}
