import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:app_todo_application/module/domain/entities/task_entity.dart';

class AddTaskUsecase {
  final IService repository;

  AddTaskUsecase(this.repository);

  Future<void> excute({
    required String title,
    required String description,
    required String date,
    required String time,
  }) async {
    final newTask = TaskEntity(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      date: date,
      time: time,
      isCompleted: false,
      createdAt: DateTime.now()
    );
    return repository.addTask(newTask);
  }
}
