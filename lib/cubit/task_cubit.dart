import 'package:app_todo_application/FirestoreService/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_todo_application/FirestoreService/firestore_service.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final IService _service;
  List<QueryDocumentSnapshot> _allTasks = [];

  TaskCubit(this._service) : super(TaskInitial());
  //hàm load dữ liệu
  void loadTasks() {
    emit(TaskLoading());
    _service.getTasks().listen((snapshot) {
      _allTasks = snapshot.docs;
      _emitLoadedState();
    }, onError: (error) => emit(TaskError("Lỗi: $error")));
  }

  // hàm xoá task
  Future<void> deleteTask(String docId) async {
    try {
      await _service.deleteTask(docId);
      // Firebase tự động cập nhật Stream, UI sẽ tự vẽ lại
    } catch (e) {
      emit(TaskError("Xóa thất bại: $e"));
    }
  }

  // Hàm cập nhật từ khóa tìm kiếm
  void updateSearch(String query) {
    _emitLoadedState(newQuery: query);
  }

  // Hàm cập nhật kiểu sắp xếp
  void updateSort(String type) {
    _emitLoadedState(newSort: type);
  }

  // Hàm bổ trợ để giữ lại các giá trị cũ khi emit state mới
  void _emitLoadedState({String? newQuery, String? newSort}) {
    final currentState = (state is TaskLoaded) ? (state as TaskLoaded) : null;
    // Tạo một instance mới hoàn toàn của danh sách và State
    emit(
      TaskLoaded(
        tasks: List.from(
          _allTasks,
        ), // Quan trọng: Dùng List.from để tạo bản sao mới
        searchQuery: newQuery ?? currentState?.searchQuery ?? '',
        sortType: newSort ?? currentState?.sortType ?? 'Newest',
      ),
    );
  }
}
