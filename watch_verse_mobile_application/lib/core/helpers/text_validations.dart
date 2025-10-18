import 'package:watch_verse/core/helpers/app_regex.dart';

class TextValidations {
  final String passwordText;
  TextValidations({required this.passwordText});


  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return "The name must be at least 3 characters.";
    }
    // Add more email validation logic if needed
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!AppRegex.isEmailValid(value)) {
      return 'Email is not valid';
    }
    // Add more email validation logic if needed
    return null;
  }

  static String? passwordSignupValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (!AppRegex.isPasswordValid(value)) {
      return "";
    }

    return null;
  }

   static String? passwordLoginValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  String? passwordConfirmationValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password Confirmation is required";
    }
    if (passwordText != value) {
      return "Passwords must match";
    }

    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (!AppRegex.isPhoneNumberValid(value)) {
      return "Phone number is not valid";
    }

    return null;
  }
}
