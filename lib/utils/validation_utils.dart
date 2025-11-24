class ValidationUtils {
  // Email validation regex pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Validate email
  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  // Validate password length
  static bool isValidPasswordLength(String password) {
    return password.length >= 6;
  }

  // Validate if two passwords match
  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  // Validate if string is not empty
  static bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }

  // Get error message for invalid email
  static String? getEmailErrorMessage(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Get error message for invalid password
  static String? getPasswordErrorMessage(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (!isValidPasswordLength(password)) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Get error message for password mismatch
  static String? getPasswordMatchErrorMessage(
    String password,
    String confirmPassword,
  ) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Get error message for empty name
  static String? getNameErrorMessage(String name) {
    if (name.trim().isEmpty) {
      return 'Name is required';
    }
    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Sanitize email input
  static String sanitizeEmail(String email) {
    return email.trim().toLowerCase();
  }

  // Sanitize name input
  static String sanitizeName(String name) {
    return name.trim();
  }
}
