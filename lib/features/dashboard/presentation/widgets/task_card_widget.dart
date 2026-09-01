import 'package:flutter/material.dart';
import 'package:todo_app/features/tasks/data/models/taskModel.dart';

class TaskCard extends StatelessWidget {
  final Taskmodel task;

  const TaskCard({super.key, required this.task});

  Color get _statusColor {
    switch (task.status) {
      case TaskStatus.completed:
        return const Color(0xFF34C759);
      case TaskStatus.inProgress:
        return const Color(0xFFFF9500);
      case TaskStatus.pending:
      case null:
        return Colors.grey.shade500;
    }
  }

  String get _statusLabel {
    switch (task.status) {
      case TaskStatus.completed:
        return 'completed';
      case TaskStatus.inProgress:
        return 'in progress';
      case TaskStatus.pending:
      case null:
        return 'pending';
    }
  }

  Color get _priorityColor {
    switch (task.priority) {
      case TaskPriority.high:
        return const Color(0xFFFF3B30);
      case TaskPriority.medium:
        return const Color(0xFFFF9500);
      case TaskPriority.low:
      case null:
        return const Color(0xFF34C759);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 6, right: 8),
                decoration: BoxDecoration(
                  color: _priorityColor,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.grey.shade400, size: 20),
            ],
          ),
          if (task.description != null && task.description!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                task.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _statusLabel,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: _statusColor,
                    ),
                  ),
                ),
                if (task.deliveryDate != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(width: 4),
                  // Text(
                  //   DateFormat('MMM d').format(task.deliveryDate!),
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.grey.shade500,
                  //   ),
                  // ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
