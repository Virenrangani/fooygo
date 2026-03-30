import '../../constant/string/custom_string.dart';

String? validatePassword(String password) {
  if (password.isEmpty) return CustomString.passwordRequired;
  if (password.length < 8) return CustomString.passwordMinChar;
  if(password.contains(" ")) return CustomString.passwordNotContainsSpace;

  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return CustomString.atLeastOneUpperCase;
  }

  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return CustomString.atLeastOneUpperCase;
  }

  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return CustomString.atLeastOneNumber;
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return CustomString.atLeastOneSpecialChar;
  }

  return null;
}