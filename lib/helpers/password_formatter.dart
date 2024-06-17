class PasswordValidator {
  static bool isPasswordValid(String value) {
    // Check if the password length is at least 6 characters
    if (value.length < 6) {
      return false;
    }

    // Check if the password contains at least one number
    if (!value.contains(RegExp(r'\d'))) {
      return false;
    }

    // Check if the password contains at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    // Check if the password contains at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    // Check if the password contains at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    return true;
  }
}
