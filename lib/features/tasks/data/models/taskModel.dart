enum TaskStatus { pending, inProgress, completed }

enum TaskPriority { high, medium, low }

class Taskmodel {
  final int id;
  final String title;
  final String? description;
  final DateTime? deliveryDate;
  final TaskStatus? status;
  final TaskPriority? priority;
  final DateTime? createdAt;

  Taskmodel({
    required this.id,
    required this.title,
    this.description,
    this.deliveryDate,
    this.status,
    this.priority,
    this.createdAt,
  });

  factory Taskmodel.fromJson(Map<String, dynamic> json) {
    return Taskmodel(
      id: json['taskId'],
      title: json['title'],
      description: json['description'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.tryParse(json['deliveryDate'])
          : null,
      status: _statusFromString(json['status']),
      priority: _priorityFromString(json['priority']),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'status': status?.name,
      'priority': priority?.name,
    };
  }

  static TaskStatus? _statusFromString(String? value) {
    switch (value) {
      case 'pending':
        return TaskStatus.pending;
      case 'in_progress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      default:
        return null;
    }
  }

  static TaskPriority? _priorityFromString(String? value) {
    switch (value) {
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      case 'low':
        return TaskPriority.low;
      default:
        return null;
    }
  }
}
