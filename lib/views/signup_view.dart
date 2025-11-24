import 'package:flutter/material.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import '../themes/text_styles.dart';
import '../themes/colors.dart';
import '../services/auth_service.dart';

class SignUpView extends StatefulWidget {
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await AuthService.signUp(
        emailController.text.trim(),
        passwordController.text,
        confirmPasswordController.text,
        nameController.text.trim(),
      );

      if (!mounted) return;

      if (response.isSuccess) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        setState(() {
          errorMessage = response.message;
        });
        _showErrorSnackbar(response.message);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'An error occurred. Please try again.';
        });
        _showErrorSnackbar('An error occurred. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: AppTextStyles.heading2.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F172A), // Dark blue
              Color(0xFF1E3A8A), // Deep blue
              Color(0xFF0EA5E9), // Cyan
              Color(0xFF06B6D4), // Sky blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Join Us Today!',
                    style: AppTextStyles.heading1.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Create your account to get started',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 32),
                  // Form container with glass effect
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF0F172A).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Full Name',
                            controller: nameController,
                            enabled: !isLoading,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            hintText: 'Email Address',
                            controller: emailController,
                            enabled: !isLoading,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: true,
                            controller: passwordController,
                            enabled: !isLoading,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            hintText: 'Confirm Password',
                            obscureText: true,
                            controller: confirmPasswordController,
                            enabled: !isLoading,
                          ),
                          if (errorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text(
                                errorMessage!,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          SizedBox(height: 24),
                          CustomButton(
                            text: isLoading ? 'Creating Account...' : 'Sign Up',
                            onPressed: isLoading ? null : _handleSignUp,
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              GestureDetector(
                                onTap: isLoading
                                    ? null
                                    : () {
                                        Navigator.pop(context);
                                      },
                                child: Text(
                                  'Sign In',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
