class UpdateProfileParams {
  final String userId;
  final String password;
  final String firstName;
  final String lastName;
  final String image;

  UpdateProfileParams({
    required this.userId,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'password': password,
    'firstname': firstName,
    'lastname': lastName,
    'image': image,
  };
}
