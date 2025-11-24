import 'package:flutter/material.dart';
import '../themes/text_styles.dart';
import '../themes/colors.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class EditTaskDialog extends StatefulWidget {
  final Map<String, dynamic> task;

  const EditTaskDialog({required this.task});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dueDateController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task['title'] ?? '');
    descriptionController = TextEditingController(
      text: widget.task['description'] ?? '',
    );
    dueDateController = TextEditingController(
      text: widget.task['dueDate'] ?? '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );

    if (picked != null) {
      dueDateController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Task',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Task Title',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              CustomTextField(
                hintText: 'Enter task title',
                controller: titleController,
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              CustomTextField(
                hintText: 'Enter task description',
                controller: descriptionController,
              ),
              SizedBox(height: 16),
              Text(
                'Due Date',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dueDateController.text.isEmpty
                            ? 'Select due date'
                            : dueDateController.text,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: dueDateController.text.isEmpty
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                      isPrimary: false,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Save Changes',
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            descriptionController.text.isEmpty ||
                            dueDateController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill all fields'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }
                        Navigator.pop(context, {
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'dueDate': dueDateController.text,
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
