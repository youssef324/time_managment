# Quick Reference Guide - Authentication System

## 🔑 Demo Credentials
```
Email: demo@example.com
Password: password123
```

## 📍 Key Routes
- `/login` - Login screen (initial route)
- `/signup` - Sign-up screen
- `/home` - Home screen (protected)
- `/task_details` - Task details screen (protected)

## 🔧 Quick API Reference

### AuthService
```dart
// Login
AuthResponse response = await AuthService.login(email, password);

// Sign Up
AuthResponse response = await AuthService.signUp(email, password, confirmPassword, name);

// Logout
await AuthService.logout();

// Check if logged in
bool isLoggedIn = AuthService.isLoggedIn();

// Get current user
User? user = AuthService.getCurrentUser();

// Get all users (demo only)
List<User> users = AuthService.getAllUsers();
```

### ValidationUtils
```dart
// Email validation
bool valid = ValidationUtils.isValidEmail(email);
String? error = ValidationUtils.getEmailErrorMessage(email);

// Password validation
bool valid = ValidationUtils.isValidPasswordLength(password);
String? error = ValidationUtils.getPasswordErrorMessage(password);

// Name validation
String? error = ValidationUtils.getNameErrorMessage(name);

// Sanitization
String cleanEmail = ValidationUtils.sanitizeEmail(email);
String cleanName = ValidationUtils.sanitizeName(name);
```

### AuthProvider (State Management)
```dart
// Initialize
await authProvider.initializeAuth();

// Login
bool success = await authProvider.login(email, password);

// Sign Up
bool success = await authProvider.signUp(email, password, confirmPassword, name);

// Logout
await authProvider.logout();

// Getters
User? user = authProvider.currentUser;
bool loading = authProvider.isLoading;
String? error = authProvider.errorMessage;
bool loggedIn = authProvider.isLoggedIn;

// Clear error
authProvider.clearError();
```

## 📋 Form Validation Rules

### Email
- Format: `example@domain.com`
- Required on both login and signup
- Must be unique on signup
- Case-insensitive

### Password
- Minimum 6 characters
- Required on both login and signup
- Must match confirmation on signup
- Case-sensitive

### Name (Signup only)
- Required
- Minimum 2 characters
- Trimmed of whitespace

## 🎨 UI Components

### CustomButton
```dart
CustomButton(
  text: 'Click me',
  onPressed: () {},
  isPrimary: true, // or false for secondary style
)
```

### CustomTextField
```dart
CustomTextField(
  hintText: 'Enter text',
  controller: controller,
  obscureText: false,
  enabled: true,
)
```

## 🧪 Common Tasks

### Login User
```dart
final response = await AuthService.login('user@example.com', 'password123');
if (response.isSuccess) {
  Navigator.pushNamed(context, '/home');
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(response.message)),
  );
}
```

### Sign Up User
```dart
final response = await AuthService.signUp(
  'newuser@example.com',
  'password123',
  'password123',
  'John Doe',
);
if (response.isSuccess) {
  Navigator.pushNamed(context, '/home');
}
```

### Check Authentication Status
```dart
if (AuthService.isLoggedIn()) {
  final user = AuthService.getCurrentUser();
  Text('Welcome, ${user?.name}');
} else {
  Text('Please log in');
}
```

### Logout User
```dart
await AuthService.logout();
Navigator.pushNamedAndRemoveUntil(
  context,
  '/login',
  (route) => false,
);
```

## 🐛 Troubleshooting

### User stays on login after entering credentials
- Check if `/home` route is properly defined in `app_routes.dart`
- Verify `AuthService.isLoggedIn()` returns `true`

### "User not found" error
- Check if user is registered in `AuthService._users` list
- Use demo account: `demo@example.com`

### Fields not disabling during load
- Ensure `enabled` parameter is passed to `CustomTextField`
- Check `isLoading` state is updating in view

### Error messages not showing
- Verify `ScaffoldMessenger` is properly initialized
- Check `errorMessage` state is being set

## 📚 Files Reference

| File | Purpose |
|------|---------|
| `lib/services/auth_service.dart` | Core auth logic |
| `lib/models/user_model.dart` | User data model |
| `lib/models/auth_response.dart` | Response models |
| `lib/providers/auth_provider.dart` | State management |
| `lib/utils/validation_utils.dart` | Input validation |
| `lib/views/login_view.dart` | Login UI |
| `lib/views/signup_view.dart` | Sign-up UI |
| `lib/widget/app_routes.dart` | Route definitions |

## 🔐 Security Reminders

- ✅ Emails are case-insensitive (normalized)
- ✅ Passwords are case-sensitive
- ✅ Minimum password length enforced
- ✅ Input validation on all fields
- ⚠️ DO NOT store passwords in plain text in production
- ⚠️ DO NOT commit API keys or secrets to git
- ⚠️ Always validate on server-side as well

## 🚀 Next Steps

1. Test with demo account
2. Create a new account
3. Test login/logout flow
4. Integrate with backend API
5. Add email verification
6. Implement session persistence
7. Add forgot password feature

## 📞 Need Help?

See:
- `AUTH_SYSTEM.md` - Detailed documentation
- `AUTH_EXAMPLES.dart` - Code examples
- `IMPLEMENTATION_SUMMARY.md` - Complete summary

---

**Quick Tip**: Press `Ctrl+F` in this file to search for specific topics!
