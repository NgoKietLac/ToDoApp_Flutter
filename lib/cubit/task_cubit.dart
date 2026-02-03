import 'dart:async';
import 'package:app_todo_application/FirestoreService/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final IService _service;
  List<QueryDocumentSnapshot> _allTasks = [];
  StreamSubscription? _taskSubscription;

  TaskCubit(this._service) : super(TaskInitial());
  //hàm load dữ liệu
  void loadTasks() {
    _taskSubscription?.cancel();

    emit(TaskLoading());
    _taskSubscription = _service.getTasks().listen((snapshot) {
      _allTasks = snapshot.docs;
      _emitLoadedState();
    }, onError: (error) => emit(TaskError("Lỗi: $error")));
  }

  // hàm xoá task
  Future<void> deleteTask(String docId) async {
    try {
      await _service.deleteTask(docId);
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
    emit(
      TaskLoaded(
        tasks: List.from(_allTasks),
        searchQuery: newQuery ?? currentState?.searchQuery ?? '',
        sortType: newSort ?? currentState?.sortType ?? 'Newest',
      ),
    );
  }

  // hàm clear dữ liệu khi logout
  void clearTasks() {
    _taskSubscription?.cancel();
    _allTasks = [];
    emit(TaskInitial());
  }

  @override
  Future<void> close() {
    _taskSubscription?.cancel();
    return super.close();
  }
}
