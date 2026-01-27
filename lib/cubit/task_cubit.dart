import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_todo_application/FirestoreService/firestore_service.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final FirestoreService _firestoreService = FirestoreService();

  TaskCubit() : super(TaskInitial());
  //hàm load dữ liệu
  void loadTasks() {
    emit(TaskLoading());
    _firestoreService.getTasks().listen(
      (snapshot) {
        emit(TaskLoaded(snapshot.docs));
      },
      onError: (error) {
        emit(TaskError("Không thể tải dữ liệu: $error"));
      },
    );
  }

  // hàm xoá task
  Future<void> deleteTask(String docId) async {
    try {
      await _firestoreService.deleteTask(docId);
      // Firebase tự động cập nhật Stream, UI sẽ tự vẽ lại
    } catch (e) {
      emit(TaskError("Xóa thất bại: $e"));
    }
  }
  
}
