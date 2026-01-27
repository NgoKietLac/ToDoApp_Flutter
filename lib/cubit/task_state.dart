import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskState {}

// 1. Trạng thái khởi tạo
class TaskInitial extends TaskState {}

// 2. Trạng thái đang tải dữ liệu từ Firebase
class TaskLoading extends TaskState {}

// 3. Trạng thái đã tải dữ liệu thành công
class TaskLoaded extends TaskState {
  final List<QueryDocumentSnapshot> tasks;
  TaskLoaded(this.tasks);
}

// 4. Trạng thái xảy ra lỗi
class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
