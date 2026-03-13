import '../../constant/string/custom_string.dart';

String? validateEmail(String email) {
  final emailValue = email.trim().toLowerCase();

  if (emailValue.isEmpty) return CustomString.emailRequired;
  if (emailValue.contains(" ")) return CustomString.emailNotContainsSpace;

  final regex = RegExp(
    r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
  );

  if (!regex.hasMatch(emailValue)) {
    return CustomString.emailValid;
  }

  return null;
}

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