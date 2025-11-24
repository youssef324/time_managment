import 'package:flutter/material.dart';
import '../themes/themes/colors.dart';
import '../themes/themes/text_styles.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;
  final VoidCallback onTap;

  const TaskCard({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.accent.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check_circle : Icons.access_time,
            color: isCompleted ? AppColors.accent : AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(description, style: AppTextStyles.bodyMedium),
            SizedBox(height: 4),
            Text('Due: $dueDate', style: AppTextStyles.bodySmall),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}