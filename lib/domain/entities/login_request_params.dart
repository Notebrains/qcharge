class LoginRequestParams {
  final String mobile;
  final String password;

  LoginRequestParams({
    required this.mobile,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'password': password,
      };
}
