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

