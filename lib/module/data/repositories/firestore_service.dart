import 'package:app_todo_application/module/data/models/task_model.dart';
import 'package:app_todo_application/module/domain/entities/task_entity.dart';
import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService implements IService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Hàm bổ trợ để lấy đường dẫn đến subcollection tasks của user hiện tại
  CollectionReference get _userTasks {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;

    if (userId == null) {
      throw Exception("User chưa đăng nhập");
    }
    // Lệnh in này sẽ xuất hiện ở terminal/console của VS Code
    print("--- DEBUG AUTH ---");
    print("Email hiện tại: ${user?.email}");
    print("UID hiện tại: $userId");
    print("------------------");

    return _firestore.collection('users').doc(userId).collection('tasks');
  }

  @override
  Stream<QuerySnapshot> getTasks() {
    try {
      // Truy vấn thẳng vào subcollection của user đó
      return _userTasks.orderBy('createdAt', descending: true).snapshots();
    } catch (e) {
      return const Stream.empty();
    }
  }

  @override
  Future<void> deleteTask(String docId) {
    return _userTasks.doc(docId).delete();
  }

  @override
  Future<void> updateTaskStatus(String docId, bool status) {
    return _userTasks.doc(docId).update({'isCompleted': status});
  }

  @override
  Future<void> updateTask(
    String docId, {
    required String title,
    required String description,
    required String date,
    required String time,
  }) {
    return _userTasks.doc(docId).update({
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    });
  }

  @override
  Future<void> addTask(TaskEntity task) {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      time: task.time,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
    );
    return _userTasks.doc(taskModel.id).set(taskModel.toMap());
  }
}
