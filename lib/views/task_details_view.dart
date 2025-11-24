import 'package:flutter/material.dart';
import '../themes/text_styles.dart';
import '../themes/colors.dart';
import '../widget/custom_button.dart';
import '../services/task_service.dart';

class TaskDetailsView extends StatefulWidget {
  final Map<String, dynamic>? task;

  const TaskDetailsView({this.task});

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  late Map<String, dynamic> currentTask;

  @override
  void initState() {
    super.initState();
    currentTask = widget.task ?? {};
  }

  void _markAsComplete() {
    final taskId = currentTask['id'];
    TaskService.markAsCompleted(taskId);
    setState(() {
      currentTask['isCompleted'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task marked as complete!'),
        backgroundColor: AppColors.accent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
            Navigator.pop(context, currentTask);
          },
        ),
      ),
      body: currentTask.isEmpty
          ? Center(child: Text('No task data'))
          : _buildTaskDetails(context),
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
                          color: currentTask['isCompleted']
                              ? AppColors.accent.withOpacity(0.1)
                              : AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          currentTask['isCompleted']
                              ? Icons.check_circle
                              : Icons.access_time,
                          color: currentTask['isCompleted']
                              ? AppColors.accent
                              : AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          currentTask['title'] ?? 'No title',
                          style: AppTextStyles.heading3.copyWith(
                            decoration: currentTask['isCompleted']
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    currentTask['description'] ?? 'No description',
                    style: AppTextStyles.bodyMedium,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Due Date',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    currentTask['dueDate'] ?? 'No due date',
                    style: AppTextStyles.bodyMedium,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Status',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: currentTask['isCompleted']
                          ? AppColors.accent.withOpacity(0.1)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      currentTask['isCompleted'] ? 'Completed' : 'In Progress',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: currentTask['isCompleted']
                            ? AppColors.accent
                            : AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          if (!currentTask['isCompleted'])
            CustomButton(text: 'Mark as Complete', onPressed: _markAsComplete),
          if (!currentTask['isCompleted']) SizedBox(height: 12),
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
