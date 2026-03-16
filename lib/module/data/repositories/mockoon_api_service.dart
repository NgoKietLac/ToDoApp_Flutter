import 'dart:convert';
import 'package:app_todo_application/module/data/models/task_model.dart';
import 'package:app_todo_application/module/domain/entities/task_entity.dart';
import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:http/http.dart' as http;

class MockoonApiService implements IService {
  // final String baseUrl = 'http://10.0.2.2:3000/tasks';
  final String baseUrl = 'http://localhost:3000/tasks';
  @override
  Future<void> addTask(TaskEntity task) async {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      time: task.time,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      isPin: task.isPin,
    );

    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(taskModel.toMap()),
    );
  }

  @override
  Future<void> deleteTask(String docId) async {
    await http.delete(Uri.parse('$baseUrl/$docId'));
  }

  @override
  Stream<List<TaskEntity>> getTasks({int limit = 10}) async* {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final tasks = data.map((json) {
          return TaskModel.fromMap(json, json['id'] ?? '');
        }).toList();
        yield tasks;
      } else {
        yield [];
      }
    } catch (e) {
      print("Lỗi Mockoon API: $e");
      yield [];
    }
  }

  @override
  Future<void> updateTask(
    String docID, {
    required String title,
    required String description,
    required String date,
    required String time,
  }) async {
    await http.patch(
      Uri.parse('$baseUrl/$docID'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'description': description,
        'date': date,
        'time': time,
      }),
    );
  }

  @override
  Future<void> updateTaskPin(String docId, bool isPin) async {
    await http.patch(
      Uri.parse('$baseUrl/$docId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'isPin': isPin}),
    );
  }

  @override
  Future<void> updateTaskStatus(String docId, bool status) async {
    await http.patch(
      Uri.parse('$baseUrl/$docId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'isCompleted': status}),
    );
  }
}
