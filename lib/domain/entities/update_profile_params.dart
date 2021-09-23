class UpdateProfileParams {
  final String mobile;
  final String password;

  UpdateProfileParams({
    required this.mobile,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'mobile': mobile,
    'password': password,
  };
}
