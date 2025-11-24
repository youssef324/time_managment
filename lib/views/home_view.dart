import 'package:flutter/material.dart';
import '../widget/task_card.dart';
import '../themes/text_styles.dart';
import '../themes/colors.dart';

class HomeView extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Complete Flutter Assignment',
      'description': 'Implement 3 pages with navigation',
      'dueDate': 'Tomorrow',
      'isCompleted': false,
    },
    {
      'title': 'Design Review Meeting',
      'description': 'Review UI designs with team',
      'dueDate': 'Today, 2:00 PM',
      'isCompleted': true,
    },
    {
      'title': 'Project Documentation',
      'description': 'Update project documentation',
      'dueDate': 'Dec 25, 2024',
      'isCompleted': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            Text('Today\'s Tasks', style: AppTextStyles.heading3),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    title: task['title'],
                    description: task['description'],
                    dueDate: task['dueDate'],
                    isCompleted: task['isCompleted'],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/task_details',
                        arguments: task,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
