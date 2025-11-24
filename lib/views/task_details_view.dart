import 'package:flutter/material.dart';
import '../themes/text_styles.dart';
import '../themes/colors.dart';
import '../widgets/custom_button.dart';

class TaskDetailsView extends StatelessWidget {
  final Map<String, dynamic>? task;

  const TaskDetailsView({this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details', style: AppTextStyles.heading2),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: task == null ? Center(child: Text('No task data')) : _buildTaskDetails(context),
    );
  }

  Widget _buildTaskDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: task!['isCompleted'] 
                              ? AppColors.accent.withOpacity(0.1) 
                              : AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          task!['isCompleted'] ? Icons.check_circle : Icons.access_time,
                          color: task!['isCompleted'] ? AppColors.accent : AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          task!['title'],
                          style: AppTextStyles.heading3.copyWith(
                            decoration: task!['isCompleted'] 
                                ? TextDecoration.lineThrough 
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Description', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text(task!['description'], style: AppTextStyles.bodyMedium),
                  SizedBox(height: 16),
                  Text('Due Date', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text(task!['dueDate'], style: AppTextStyles.bodyMedium),
                  SizedBox(height: 16),
                  Text('Status', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: task!['isCompleted'] ? AppColors.accent.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      task!['isCompleted'] ? 'Completed' : 'In Progress',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: task!['isCompleted'] ? AppColors.accent : AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          if (!task!['isCompleted'])
            CustomButton(
              text: 'Mark as Complete',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task marked as complete!')),
                );
              },
            ),
          SizedBox(height: 12),
          CustomButton(
            text: 'Edit Task',
            onPressed: () {
              // Handle edit task
            },
            isPrimary: false,
          ),
        ],
      ),
    );
  }
}