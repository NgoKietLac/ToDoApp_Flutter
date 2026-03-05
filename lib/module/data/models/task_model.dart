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
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String docId) {
    return TaskModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
