import 'package:app_todo_application/module/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.time,
    required super.isCompleted,
    required super.createdAt,
    required super.isPin,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String docId) {
    DateTime parsedDate;
    if (map['createdAt'] is Timestamp) {
      parsedDate = (map['createdAt'] as Timestamp).toDate();
    } else if (map['createdAt'] is String) {
      parsedDate = DateTime.tryParse(map['createdAt']) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return TaskModel(
      id: map['id'] ?? docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: parsedDate,
      isPin: map['isPin'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'isPin': isPin,
    };
  }
}
