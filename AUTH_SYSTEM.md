# Authentication System Documentation

## Overview
This task management app includes a complete authentication system with login and sign-up functionality. The system uses an in-memory storage approach for demo purposes but can be easily extended to use a backend API or database.

## Features

### 1. Login System
- **Email Validation**: Verifies email format before submission
- **Password Validation**: Ensures password is provided
- **User Lookup**: Searches for user in database
- **Error Handling**: Provides clear error messages
- **Loading State**: Shows loading indicator during authentication
- **Session Management**: Maintains current user session

### 2. Sign-Up System
- **Full Name Validation**: Ensures name is provided
- **Email Validation**: Validates email format and checks for duplicates
- **Password Validation**: 
  - Minimum 6 characters
  - Matches confirmation password
- **Account Creation**: Creates new user account
- **Automatic Login**: Logs in user after successful registration

### 3. Security Features
- Password confirmation on sign-up
- Email uniqueness validation
- Input validation on all fields
- Error messages don't reveal sensitive information

## Architecture

### File Structure
```
lib/
├── models/
│   ├── user_model.dart           # User data model
│   └── auth_response.dart        # Authentication response models
├── services/
│   └── auth_service.dart         # Core authentication logic
├── providers/
│   └── auth_provider.dart        # State management (ChangeNotifier)
├── views/
│   ├── login_view.dart           # Login screen
│   ├── signup_view.dart          # Sign-up screen
│   └── ...
└── widget/
    └── app_routes.dart           # Route definitions
```

### Core Components

#### 1. **AuthService** (`lib/services/auth_service.dart`)
Static service handling all authentication logic:
- `login(email, password)` - Authenticates user
- `signUp(email, password, confirmPassword, name)` - Creates new account
- `logout()` - Clears current session
- `getCurrentUser()` - Returns currently logged-in user
- `isLoggedIn()` - Checks if user is authenticated

#### 2. **AuthProvider** (`lib/providers/auth_provider.dart`)
State management using ChangeNotifier:
- Manages authentication state
- Exposes current user and loading status
- Notifies listeners of state changes
- Can be wrapped with MultiProvider for dependency injection

#### 3. **User Model** (`lib/models/user_model.dart`)
Data class representing a user:
```dart
User {
  String id;
  String email;
  String name;
  String password;  // In production, only store hashed password
  DateTime createdAt;
}
```

#### 4. **LoginView** (`lib/views/login_view.dart`)
- Form with email and password fields
- Validates inputs before submission
- Shows loading state during authentication
- Displays error messages
- Links to sign-up screen
- Remember password option placeholder

#### 5. **SignUpView** (`lib/views/signup_view.dart`)
- Form with name, email, password, and confirmation fields
- Real-time validation feedback
- Shows loading state during account creation
- Links back to login screen
- Error message display

## Demo Account
For testing purposes, there's a pre-configured demo account:
- **Email**: `demo@example.com`
- **Password**: `password123`

## Usage Examples

### Login
```dart
final response = await AuthService.login('user@example.com', 'password123');
if (response.isSuccess) {
  print('Login successful: ${response.userId}');
} else {
  print('Error: ${response.message}');
}
```

### Sign Up
```dart
final response = await AuthService.signUp(
  'newuser@example.com',
  'securepass123',
  'securepass123',
  'John Doe',
);
if (response.isSuccess) {
  print('Account created successfully');
}
```

### Using AuthProvider
```dart
// With Provider package (if added to pubspec.yaml)
Consumer<AuthProvider>(
  builder: (context, authProvider, _) {
    if (authProvider.isLoggedIn) {
      return Text('Welcome, ${authProvider.currentUser?.name}');
    }
    return Text('Please log in');
  },
)
```

## Validation Rules

### Email
- Must be a valid email format (example@domain.com)
- Must be unique during sign-up
- Case-insensitive for login

### Password
- Minimum 6 characters
- Must match confirmation password on sign-up
- Case-sensitive

### Name
- Required field
- Trimmed of whitespace

## Error Messages
The system provides user-friendly error messages:
- "Email is required"
- "Please enter a valid email"
- "Password is required"
- "Password must be at least 6 characters"
- "Passwords do not match"
- "Name is required"
- "User not found. Please create an account."
- "Invalid email or password"
- "Email already registered"

## Future Enhancements

### 1. Backend Integration
Replace in-memory storage with API calls:
```dart
Future<AuthResponse> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://api.example.com/auth/login'),
    body: {'email': email, 'password': password},
  );
  // Handle response
}
```

### 2. Password Recovery
Implement forgot password functionality with email verification

### 3. Security Improvements
- Use bcrypt or similar for password hashing
- Implement JWT tokens for session management
- Add refresh token mechanism
- Implement rate limiting for login attempts

### 4. Database Integration
- Use Firebase, Supabase, or SQLite
- Implement proper password hashing
- Add user profile data storage

### 5. OAuth Integration
- Add Google sign-in
- Add Apple sign-in
- Add Facebook login

### 6. Multi-factor Authentication
- Email verification
- SMS verification
- Authenticator app support

### 7. User Profile Management
- Edit profile information
- Change password
- Delete account
- Avatar/profile picture

### 8. State Persistence
- Use SharedPreferences to remember login session
- Implement auto-login on app restart
- Add "Remember me" functionality

## Testing

### Test Credentials
```
Email: demo@example.com
Password: password123
```

### Test Cases
1. **Valid Login** - Use demo credentials
2. **Invalid Password** - Correct email, wrong password
3. **User Not Found** - Email not registered
4. **Weak Password** - Less than 6 characters
5. **Duplicate Email** - Try signing up with demo email
6. **Password Mismatch** - Different password confirmation
7. **Empty Fields** - Submit with blank fields

## Notes for Developers
- In production, never store plaintext passwords
- Always use HTTPS for authentication endpoints
- Implement proper session management
- Use token-based authentication (JWT)
- Add rate limiting to prevent brute force attacks
- Implement audit logging for security events
- Use environment variables for sensitive configuration
