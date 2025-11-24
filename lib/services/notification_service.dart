class NotificationItem {
  final String id;
  final String title;
  final String body;
  bool isRead;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.createdAt,
  });
}

class NotificationService {
  static final List<NotificationItem> _notifications = [];

  static List<NotificationItem> getAll() => _notifications;

  static void add(String title, String body) {
    _notifications.insert(
      0,
      NotificationItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        body: body,
        createdAt: DateTime.now(),
      ),
    );
  }

  static void markRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
    }
  }

  static void remove(String id) {
    _notifications.removeWhere((n) => n.id == id);
  }

  static void clearAll() {
    _notifications.clear();
  }
}
