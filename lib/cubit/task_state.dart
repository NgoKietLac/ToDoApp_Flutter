import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskState {}

//  Trạng thái khởi tạo
class TaskInitial extends TaskState {}

// Trạng thái đang tải dữ liệu từ Firebase
class TaskLoading extends TaskState {}

// Trạng thái đã tải dữ liệu thành công
class TaskLoaded extends TaskState {
  final List<QueryDocumentSnapshot> tasks;
  final String searchQuery;
  final String sortType;

  TaskLoaded({
    required this.tasks,
    this.searchQuery = '',
    this.sortType = 'Newest',
  });
  List<QueryDocumentSnapshot> get filteredTasks {
    // 1. Lọc theo Search
    List<QueryDocumentSnapshot> list = tasks.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final title = (data['title'] ?? "").toString().toLowerCase();
      return title.contains(searchQuery.toLowerCase());
    }).toList();
    // 2. Sắp xếp theo SortType
    if (sortType == 'Alpha') {
      list.sort(
        (a, b) => a['title'].toString().compareTo(b['title'].toString()),
      );
    }
    return list;
  }
}

// Trạng thái xảy ra lỗi
class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
