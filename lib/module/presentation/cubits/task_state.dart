import 'package:app_todo_application/module/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskState {}

//  Trạng thái khởi tạo
class TaskInitial extends TaskState {}

// Trạng thái đang tải dữ liệu từ Firebase
class TaskLoading extends TaskState {}

// Trạng thái đã tải dữ liệu thành công
class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;
  final String searchQuery;
  final String sortType;
  final bool isActionSuccess;

  TaskLoaded({
    required this.tasks,
    this.searchQuery = '',
    this.sortType = 'Newest', 
    this.isActionSuccess = false,
  });
  List<TaskEntity> get filteredTasks {
    // 1. Lọc theo Search
    List<TaskEntity> list = tasks.where((doc) {
      return doc.title.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    // 2. Sắp xếp theo SortType
    if (sortType == 'Alpha') {
      list.sort((a, b) => a.title.compareTo(b.title));
    }
    return list;
  }

  TaskLoaded copyWith({
    List<TaskEntity>? tasks,
    String? searchQuery,
    String? sortType,
    bool? isActionSuccess,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      searchQuery: searchQuery ?? this.searchQuery,
      sortType: sortType ?? this.sortType,
      isActionSuccess: isActionSuccess ?? false,
    );
  }
}

// Trạng thái xảy ra lỗi
class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
