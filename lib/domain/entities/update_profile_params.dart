class UpdateProfileParams {
  final String userId;
  final String password;

  UpdateProfileParams({
    required this.userId,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'password': password,
  };
}
