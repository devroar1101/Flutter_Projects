String? validateEmail(String value) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (value.isEmpty) {
    return 'Email cannot be empty';
  } else if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePhoneNumber(String value) {
  final phoneRegex = RegExp(r'^[6-9]\d{9}$'); // Indian phone number regex
  if (value.isEmpty) {
    return 'Phone number cannot be empty';
  } else if (!phoneRegex.hasMatch(value)) {
    return 'Please enter a valid 5-digit Indian phone number';
  }
  return null;
}

String? validateUsername(String value) {
  if (value.isEmpty) {
    return 'Username cannot be empty';
  } else if (value.length < 3) {
    return 'Username must be at least 3 characters long';
  }
  return null;
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}
