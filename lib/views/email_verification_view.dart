import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/text_styles.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class EmailVerificationView extends StatefulWidget {
  final String email;
  final VoidCallback onVerified;

  const EmailVerificationView({required this.email, required this.onVerified});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  late AnimationController _iconAnimationController;
  late Animation<double> _iconScale;

  // Demo verification code - in production, this would be sent via email
  static const String demoCode = '123456';

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _iconScale = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  void _verifyEmail() {
    final code = _codeController.text.trim();

    setState(() {
      _errorMessage = '';
    });

    if (code.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter the verification code';
      });
      return;
    }

    if (code.length != 6) {
      setState(() {
        _errorMessage = 'Verification code must be 6 digits';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      if (code == demoCode) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email verified successfully!'),
            backgroundColor: AppColors.accent,
          ),
        );
        widget.onVerified();
      } else {
        setState(() {
          _errorMessage = 'Invalid verification code';
        });
        _codeController.clear();
      }
    });
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification code sent to ${widget.email}'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email', style: AppTextStyles.heading2),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: SizedBox.shrink(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.accent.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _iconScale,
                    child: Icon(
                      Icons.mark_email_read,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Verify Your Email',
                    style: AppTextStyles.heading2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We\'ve sent a verification code to\n${widget.email}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Enter Verification Code',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            CustomTextField(
              hintText: 'Enter 6-digit code',
              controller: _codeController,
            ),
            if (_errorMessage.isNotEmpty) ...[
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Color(0xFFC62828),
                  ),
                ),
              ),
            ],
            SizedBox(height: 24),
            CustomButton(
              text: _isLoading ? 'Verifying...' : 'Verify Email',
              onPressed: _isLoading ? null : _verifyEmail,
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: _resendCode,
                child: Text(
                  'Didn\'t receive code? Resend',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'Demo Code: $demoCode',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
