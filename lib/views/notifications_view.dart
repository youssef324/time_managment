import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../themes/text_styles.dart';
import '../themes/colors.dart';

class NotificationsView extends StatefulWidget {
  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<NotificationItem> _items = [];

  @override
  void initState() {
    super.initState();
    _items = NotificationService.getAll();
  }

  void _toggleRead(NotificationItem item) {
    setState(() {
      item.isRead = !item.isRead;
    });
    if (item.isRead) NotificationService.markRead(item.id);
  }

  void _remove(NotificationItem item) {
    setState(() {
      NotificationService.remove(item.id);
      _items = NotificationService.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: AppTextStyles.heading2),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: _items.isEmpty
          ? Center(
              child: Text('No notifications', style: AppTextStyles.bodyLarge),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _remove(item),
                  background: Container(
                    color: AppColors.error,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(
                      item.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        decoration: item.isRead
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(item.body, style: AppTextStyles.bodyMedium),
                    trailing: IconButton(
                      onPressed: () => _toggleRead(item),
                      icon: Icon(
                        item.isRead
                            ? Icons.mark_email_read
                            : Icons.mark_email_unread,
                        color: item.isRead
                            ? AppColors.accent
                            : AppColors.primary,
                      ),
                      tooltip: item.isRead ? 'Mark as unread' : 'Mark as read',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
