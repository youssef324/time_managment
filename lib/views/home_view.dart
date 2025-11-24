import 'package:flutter/material.dart';
import '../widget/task_card.dart';
import '../themes/text_styles.dart';
import '../themes/colors.dart';
import '../services/task_service.dart';
import 'add_task_dialog.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Initialize with default tasks if empty
    if (TaskService.getTotalTasksCount() == 0) {
      TaskService.createTask(
        title: 'Complete Flutter Assignment',
        description: 'Implement 3 pages with navigation',
        dueDate: 'Tomorrow',
      );
      TaskService.createTask(
        title: 'Design Review Meeting',
        description: 'Review UI designs with team',
        dueDate: 'Today, 2:00 PM',
      );
      TaskService.markAsCompleted(TaskService.getAllTasks()[1].id);
      TaskService.createTask(
        title: 'Project Documentation',
        description: 'Update project documentation',
        dueDate: 'Dec 25, 2024',
      );
    }
  }

  void _showAddTaskDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AddTaskDialog(),
    );

    if (result != null) {
      setState(() {
        TaskService.createTask(
          title: result['title'],
          description: result['description'],
          dueDate: result['dueDate'],
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task created successfully!'),
          backgroundColor: AppColors.accent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _markTaskAsCompleted(String taskId) {
    setState(() {
      TaskService.markAsCompleted(taskId);
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
    final tasks = TaskService.getAllTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks', style: AppTextStyles.heading2),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today\'s Tasks', style: AppTextStyles.heading3),
                Text(
                  '${TaskService.getCompletedTasksCount()}/${tasks.length} Done',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 64,
                            color: AppColors.border,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tasks yet',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'Tap the + button to add a new task',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return FadeTransition(
                          opacity: AlwaysStoppedAnimation(1.0),
                          child: SlideTransition(
                            position: AlwaysStoppedAnimation(Offset.zero),
                            child: TaskCard(
                              title: task.title,
                              description: task.description,
                              dueDate: task.dueDate,
                              isCompleted: task.isCompleted,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/task_details',
                                  arguments: task.toJson(),
                                ).then((_) {
                                  setState(() {});
                                });
                              },
                              onCompleteTap: task.isCompleted
                                  ? null
                                  : () => _markTaskAsCompleted(task.id),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
