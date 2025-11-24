import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/text_styles.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;
  final VoidCallback onTap;
  final VoidCallback? onCompleteTap;

  const TaskCard({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.onTap,
    this.onCompleteTap,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimationController;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _iconScale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void didUpdateWidget(TaskCard oldWidget) {
    super.didUpdateWidget(widget);
    if (widget.isCompleted && !oldWidget.isCompleted) {
      _iconAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  void _handleCompleteTap() {
    if (widget.onCompleteTap != null) {
      _iconAnimationController.forward(from: 0.0);
      widget.onCompleteTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: GestureDetector(
          onTap: _handleCompleteTap,
          child: ScaleTransition(
            scale: _iconScale,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.isCompleted
                    ? AppColors.accent.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  widget.isCompleted ? Icons.check_circle : Icons.access_time,
                  key: ValueKey(widget.isCompleted),
                  color: widget.isCompleted
                      ? AppColors.accent
                      : AppColors.primary,
                ),
              ),
            ),
          ),
        ),
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: AppTextStyles.bodyLarge.copyWith(
            decoration: widget.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
          child: Text(widget.title),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(widget.description, style: AppTextStyles.bodyMedium),
            SizedBox(height: 4),
            Text('Due: ${widget.dueDate}', style: AppTextStyles.bodySmall),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: widget.onTap,
      ),
    );
  }
}
