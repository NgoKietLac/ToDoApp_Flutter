import 'package:app_todo_application/module/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IService {
  Future<void> addTask(TaskEntity task);

  Stream<List<TaskEntity>> getTasks({int limit = 10});

  Future<void> deleteTask(String docId);

  Future<void> updateTaskStatus(String docId, bool status);
  Future<void> updateTaskPin(String docId, bool isPin);
  Future<void> updateTask(
    String docID, {
    required String title,
    required String description,
    required String date,
    required String time,
  });
}
