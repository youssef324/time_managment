class AuthResponse {
  final bool isSuccess;
  final String message;
  final String? userId;

  AuthResponse({required this.isSuccess, required this.message, this.userId});
}

class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult({required this.isValid, this.errorMessage});
}
