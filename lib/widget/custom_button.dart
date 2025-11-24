import 'package:flutter/material.dart';
import '../themes/themes/colors.dart';
import '../themes/themes/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : AppColors.surface,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary ? BorderSide.none : BorderSide(color: AppColors.primary),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: isPrimary ? AppTextStyles.button : AppTextStyles.button.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}