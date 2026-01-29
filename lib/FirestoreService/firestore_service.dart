import 'package:app_todo_application/FirestoreService/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService implements IService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection(
    'tasks',
  );
  //hàm lấy ds task
  @override
  Stream<QuerySnapshot> getTasks() {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    return tasks
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // hàm xoá
  @override
  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }

  // hàm update trạng thái
  @override
  Future<void> updateTaskStatus(String docId, bool status) {
    return tasks.doc(docId).update({'isCompleted': status});
  }

  @override
  Future<void> addTask({
    required String title,
    required String description,
    required String date,
    required String time,
  }) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    return tasks.add({
      'userId': userId,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateTask(
    String docId, {
    required String title,
    required String description,
    required String date,
    required String time,
  }) {
    return tasks.doc(docId).update({
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    });
  }
}
