import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IService {
  Future<void> addTask({
    required String title,
    required String description,
    required String date,
    required String time,
  });

  Stream<QuerySnapshot> getTasks();

  Future<void> deleteTask(String docId);

  Future<void> updateTaskStatus(String docId, bool status);
  Future<void> updateTask(
    String docID, {
    required String title,
    required String description,
    required String date,
    required String time,
  });
}
