import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/task_details_view.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/task_details':
        final task = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) => TaskDetailsView(task: task));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
