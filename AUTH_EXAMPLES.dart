// AUTHENTICATION SYSTEM INTEGRATION EXAMPLES
// This file contains examples of how to use the authentication system

// ============================================================================
// EXAMPLE 1: PROTECTING ROUTES WITH AUTHENTICATION CHECK
// ============================================================================

/*
Modify your app_routes.dart to check authentication before navigating:

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      
      case '/home':
        // Check if user is logged in
        if (AuthService.isLoggedIn()) {
          return MaterialPageRoute(builder: (_) => HomeView());
        } else {
          // Redirect to login if not authenticated
          return MaterialPageRoute(builder: (_) => LoginView());
        }
      
      case '/task_details':
        if (AuthService.isLoggedIn()) {
          final task = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(builder: (_) => TaskDetailsView(task: task));
        } else {
          return MaterialPageRoute(builder: (_) => LoginView());
        }
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page not found'))
          ),
        );
    }
  }
}
*/

// ============================================================================
// EXAMPLE 2: CONDITIONAL HOME SCREEN BASED ON AUTH STATE
// ============================================================================

/*
Modify main.dart to show different initial routes:

void main() {
  // Check if user is already logged in
  final isLoggedIn = AuthService.isLoggedIn();
  
  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  
  MyApp({this.initialRoute = '/login'});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Color(0xFFF8FAFC),
      ),
      initialRoute: initialRoute,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
*/

// ============================================================================
// EXAMPLE 3: LOGOUT FUNCTIONALITY IN HOME VIEW
// ============================================================================

/*
Add logout button to HomeView:

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks', style: AppTextStyles.heading2),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      // ... rest of the widget
    );
  }
  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
*/

// ============================================================================
// EXAMPLE 4: DISPLAY CURRENT USER INFO
// ============================================================================

/*
Show logged-in user information in home view:

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService.getCurrentUser();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks', style: AppTextStyles.heading2),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Welcome, ${currentUser?.name}!',
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ),
        ],
      ),
      // ... rest of the widget
    );
  }
}
*/

// ============================================================================
// EXAMPLE 5: USING AUTH PROVIDER WITH PROVIDER PACKAGE
// ============================================================================

/*
First, add 'provider' package to pubspec.yaml:

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0

Then modify main.dart:

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Task Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Color(0xFFF8FAFC),
        ),
        initialRoute: '/login',
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// Use in your views:
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('My Tasks', style: AppTextStyles.heading2),
            actions: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Welcome, ${authProvider.currentUser?.name}!',
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
          // ... rest of widget
        );
      },
    );
  }
}
*/

// ============================================================================
// EXAMPLE 6: EMAIL VERIFICATION (FUTURE ENHANCEMENT)
// ============================================================================

/*
Create an EmailVerificationView:

class EmailVerificationView extends StatefulWidget {
  final String email;
  
  EmailVerificationView({required this.email});
  
  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  late TextEditingController _codeController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    // Send verification code to email
    _sendVerificationCode();
  }

  Future<void> _sendVerificationCode() async {
    // Call API to send verification code to email
  }

  Future<void> _verifyCode() async {
    setState(() => isLoading = true);
    
    // Call API to verify code
    
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Email')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter verification code sent to ${widget.email}'),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Verification Code',
              controller: _codeController,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: isLoading ? 'Verifying...' : 'Verify',
              onPressed: isLoading ? null : _verifyCode,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
*/

// ============================================================================
// EXAMPLE 7: PASSWORD RESET FLOW (FUTURE ENHANCEMENT)
// ============================================================================

/*
Create ForgotPasswordView:

class ForgotPasswordView extends StatefulWidget {
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late TextEditingController _emailController;
  bool isLoading = false;
  bool emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  Future<void> _sendResetCode() async {
    setState(() => isLoading = true);
    
    // Call API to send reset code
    
    setState(() {
      isLoading = false;
      emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (emailSent) {
      return _buildResetCodeScreen();
    }
    
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your email to reset your password'),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Email Address',
              controller: _emailController,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: isLoading ? 'Sending...' : 'Send Reset Code',
              onPressed: isLoading ? null : _sendResetCode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResetCodeScreen() {
    // Show screen to enter reset code and new password
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Enter the code sent to ${_emailController.text}'),
            // Add reset code and new password fields
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
*/

// ============================================================================
// EXAMPLE 8: PERSISTING LOGIN STATE WITH SHARED PREFERENCES
// ============================================================================

/*
Modify AuthService to persist login state:

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userIdKey = 'user_id';
  static const String _emailKey = 'user_email';
  
  static Future<void> _saveUserToPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, user.id);
    await prefs.setString(_emailKey, user.email);
  }
  
  static Future<void> _clearUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_emailKey);
  }
  
  static Future<bool> loadSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_userIdKey);
    final email = prefs.getString(_emailKey);
    
    if (userId != null && email != null) {
      // Fetch full user data from database/API
      // Set _currentUser = user
      return true;
    }
    return false;
  }
}

// In main.dart:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final isLoggedIn = await AuthService.loadSavedUser();
  final initialRoute = isLoggedIn ? '/home' : '/login';
  
  runApp(MyApp(initialRoute: initialRoute));
}
*/

// ============================================================================
// TEST CASES & DEBUGGING
// ============================================================================

/*
Testing the authentication system:

// Test 1: Valid login
void testValidLogin() {
  final response = AuthService.login('demo@example.com', 'password123');
  assert(response.isSuccess == true);
  assert(AuthService.getCurrentUser()?.email == 'demo@example.com');
}

// Test 2: Invalid password
void testInvalidPassword() {
  final response = AuthService.login('demo@example.com', 'wrongpassword');
  assert(response.isSuccess == false);
  assert(response.message.contains('Invalid'));
}

// Test 3: User not found
void testUserNotFound() {
  final response = AuthService.login('nonexistent@example.com', 'password123');
  assert(response.isSuccess == false);
}

// Test 4: Sign up new user
void testSignUp() {
  final response = AuthService.signUp(
    'newuser@example.com',
    'password123',
    'password123',
    'John Doe',
  );
  assert(response.isSuccess == true);
}

// Test 5: Duplicate email
void testDuplicateEmail() {
  final response = AuthService.signUp(
    'demo@example.com',
    'password123',
    'password123',
    'Demo User',
  );
  assert(response.isSuccess == false);
  assert(response.message.contains('already registered'));
}

// Test 6: Logout
void testLogout() async {
  await AuthService.login('demo@example.com', 'password123');
  assert(AuthService.isLoggedIn() == true);
  
  await AuthService.logout();
  assert(AuthService.isLoggedIn() == false);
}
*/
