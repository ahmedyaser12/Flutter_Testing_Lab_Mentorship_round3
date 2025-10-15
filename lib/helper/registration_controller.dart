class RegistrationController {
  // ✅ Email validation using a solid regex pattern
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // ✅ Password validation: 8+ chars, one uppercase, one lowercase, one number, one special char
  static bool isValidPassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%\^&\*]).{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  // ✅ Example form validation (simulate a simple form)
  static bool validateForm({required String email, required String password}) {
    return isValidEmail(email) && isValidPassword(password);
  }
}
