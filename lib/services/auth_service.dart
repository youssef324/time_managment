import '../models/user_model.dart';
import '../models/auth_response.dart';

class AuthService {
  // In-memory storage of users (in a real app, this would be a database)
  static final List<User> _users = [
    User(
      id: '1',
      email: 'demo@example.com',
      name: 'Demo User',
      password: 'password123',
      createdAt: DateTime.now(),
    ),
  ];

  static User? _currentUser;

  // Getter for current user
  static User? getCurrentUser() {
    return _currentUser;
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _currentUser != null;
  }

  // Login method
  static Future<AuthResponse> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Validate email and password
    final emailValidation = _validateEmail(email);
    if (!emailValidation.isValid) {
      return AuthResponse(
        isSuccess: false,
        message: emailValidation.errorMessage ?? 'Invalid email',
      );
    }

    if (password.isEmpty) {
      return AuthResponse(isSuccess: false, message: 'Password is required');
    }

    // Find user by email
    try {
      final user = _users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase(),
      );

      // Check password
      if (user.password != password) {
        return AuthResponse(
          isSuccess: false,
          message: 'Invalid email or password',
        );
      }

      // Set current user
      _currentUser = user;

      return AuthResponse(
        isSuccess: true,
        message: 'Login successful',
        userId: user.id,
      );
    } catch (e) {
      return AuthResponse(
        isSuccess: false,
        message: 'User not found. Please create an account.',
      );
    }
  }

  // Sign up method
  static Future<AuthResponse> signUp(
    String email,
    String password,
    String confirmPassword,
    String name,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Validate inputs
    if (name.isEmpty) {
      return AuthResponse(isSuccess: false, message: 'Name is required');
    }

    final emailValidation = _validateEmail(email);
    if (!emailValidation.isValid) {
      return AuthResponse(
        isSuccess: false,
        message: emailValidation.errorMessage ?? 'Invalid email',
      );
    }

    final passwordValidation = _validatePassword(password);
    if (!passwordValidation.isValid) {
      return AuthResponse(
        isSuccess: false,
        message:
            passwordValidation.errorMessage ??
            'Password does not meet requirements',
      );
    }

    if (password != confirmPassword) {
      return AuthResponse(isSuccess: false, message: 'Passwords do not match');
    }

    // Check if user already exists
    try {
      _users.firstWhere((u) => u.email.toLowerCase() == email.toLowerCase());
      return AuthResponse(
        isSuccess: false,
        message: 'Email already registered',
      );
    } catch (e) {
      // User doesn't exist, proceed with signup
    }

    // Create new user
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      password: password,
      createdAt: DateTime.now(),
    );

    _users.add(newUser);
    _currentUser = newUser;

    return AuthResponse(
      isSuccess: true,
      message: 'Account created successfully',
      userId: newUser.id,
    );
  }

  // Logout method
  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  // Email validation
  static ValidationResult _validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (email.isEmpty) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Email is required',
      );
    }

    if (!emailRegex.hasMatch(email)) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Please enter a valid email',
      );
    }

    return ValidationResult(isValid: true);
  }

  // Password validation
  static ValidationResult _validatePassword(String password) {
    if (password.isEmpty) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Password is required',
      );
    }

    if (password.length < 6) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Password must be at least 6 characters',
      );
    }

    return ValidationResult(isValid: true);
  }

  // Get all users (for testing purposes)
  static List<User> getAllUsers() {
    return _users;
  }
}
