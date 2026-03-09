class TaskEntity {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final bool isCompleted;
  final DateTime createdAt;
  final bool isPin;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.isCompleted,
    required this.createdAt,
    required this.isPin,
  });
}
