import '../models/task_model.dart';

class TaskService {
  // In-memory storage of tasks
  static final List<Task> _tasks = [];

  // Get all tasks
  static List<Task> getAllTasks() {
    return _tasks;
  }

  // Get task by ID
  static Task? getTaskById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  // Create a new task
  static Task createTask({
    required String title,
    required String description,
    required String dueDate,
  }) {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      dueDate: dueDate,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    _tasks.add(task);
    return task;
  }

  // Update task
  static Task? updateTask(
    String id, {
    String? title,
    String? description,
    String? dueDate,
    bool? isCompleted,
  }) {
    try {
      final index = _tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        _tasks[index] = _tasks[index].copyWith(
          title: title,
          description: description,
          dueDate: dueDate,
          isCompleted: isCompleted,
        );
        return _tasks[index];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Mark task as completed
  static Task? markAsCompleted(String id) {
    return updateTask(id, isCompleted: true);
  }

  // Mark task as incomplete
  static Task? markAsIncomplete(String id) {
    return updateTask(id, isCompleted: false);
  }

  // Delete task
  static bool deleteTask(String id) {
    try {
      _tasks.removeWhere((task) => task.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Clear all tasks
  static void clearAllTasks() {
    _tasks.clear();
  }

  // Get completed tasks count
  static int getCompletedTasksCount() {
    return _tasks.where((task) => task.isCompleted).length;
  }

  // Get total tasks count
  static int getTotalTasksCount() {
    return _tasks.length;
  }
}
