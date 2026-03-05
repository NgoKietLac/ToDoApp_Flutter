import 'dart:async';
import 'package:app_todo_application/module/data/models/task_model.dart';
import 'package:app_todo_application/module/domain/entities/task_entity.dart';
import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:app_todo_application/module/domain/usecases/add_task_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final IService _service;
  List<TaskEntity> _allTasks = [];
  StreamSubscription? _taskSubscription;
  final AddTaskUsecase _addTaskUsecase;

  TaskCubit(this._addTaskUsecase, this._service) : super(TaskInitial());
  //hàm load dữ liệu
  void loadTasks() {
    _taskSubscription?.cancel();
    emit(TaskLoading());

    _taskSubscription = _service.getTasks().listen((snapshot) {
      final List<TaskEntity> tasks = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromMap(data, doc.id);
      }).toList();

      _allTasks = tasks; // Lưu trữ dưới dạng Entity
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

  //hàm thêm task
  Future<void> addNewTask({
    required String title,
    required String description,
    required String date,
    required String time,
  }) async {
    emit(TaskLoading());
    try {
      await _addTaskUsecase.excute(
        title: title,
        description: description,
        date: date,
        time: time,
      );
      if (state is TaskLoaded) {
        emit((state as TaskLoaded).copyWith(isActionSuccess: true));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
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
