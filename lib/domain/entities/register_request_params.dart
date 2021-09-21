
class RegisterRequestParams {
  final String firstName;
  final String lastName;
  final String mobile;
  final String password;
  final String confirmPassword;
  final String email;
  final String brand;
  final String carModel;
  final String carName;
  final String carLicencePlate;

  RegisterRequestParams({
    required this.firstName, required this.lastName, required this.mobile, required this.password, required this.confirmPassword,
    required this.email, required this.brand, required this.carModel, required this.carName, required this.carLicencePlate
  });

  Map<String, dynamic> toJson() => {
        'firstname': firstName,
        'lastname': lastName,
        'mobile': mobile,
        'password': password,
        'confirm_password': confirmPassword,
        'email': email,
        'brand': brand,
        'model': carModel,
        'car_name': carName,
        'car_lisense_plate': carLicencePlate,
      };
}
