
String validateEmptyString(String value) {
  if (value.length == 0) {
    return "Field is required!";
  }
  return '';
}

String validateEmptyDouble(double value) {
  if (value == 0) {
    return "Field is required!";
  }
  return '';
}

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return '';
}

String validateMobile(String value) {
  if (value.length == 0) {
    return "Mobile is Required";
  } else if (value.length < 7 || value.length > 14) {
    return "Please enter valid mobile number";
  }
  return '';
}

String validateZipCode(String value) {
  if (value.length == 0) {
    return "Zip code is required";
  } else if (value.length < 5) {
    return "Please enter valid zip code";
  }
  return '';
}

bool validateEmail(String value) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0 || !regExp.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

String validatePass(String value) {
  if (value.isEmpty) {
    return 'Password is Required';
  }
  return '';
}