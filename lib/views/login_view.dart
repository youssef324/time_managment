import 'package:flutter/material.dart';
import '../themes/widget/widgets/custom_button.dart';
import '../themes/widget/widgets/custom_textfield.dart';
import '../themes/widget/themes/text_styles.dart';
import '../themes/widget/themes/colors.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text('Welcome Back!', style: AppTextStyles.heading1),
              SizedBox(height: 8),
              Text('Sign in to continue', style: AppTextStyles.bodyMedium),
              SizedBox(height: 40),
              CustomTextField(
                hintText: 'Email Address',
                controller: emailController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(height: 24),
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              SizedBox(height: 16),
              CustomButton(
                text: 'Create Account',
                onPressed: () {
                  // Handle create account
                },
                isPrimary: false,
              ),
              Spacer(),
              Center(
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}