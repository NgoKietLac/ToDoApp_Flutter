import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection(
    'tasks',
  );
  // hàm thêm
  Future<void> addtask({
    required String title,
    required String description,
    required String date,
    required String time,
  }) {
    return tasks.add({
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  //hàm lấy ds task
  Stream<QuerySnapshot> getTasks() {
    return tasks.orderBy('createdAt', descending: true).snapshots();
  }

  // hàm xoá
  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }

  // hàm update trạng thái
  Future<void> updateTaskStatus(String docId, bool status) {
    return tasks.doc(docId).update({'isCompleted': status});
  }
}
