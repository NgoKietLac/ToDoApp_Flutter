import 'package:app_todo_application/FirestoreService/firestore_service.dart';
import 'package:app_todo_application/FirestoreService/service.dart';
import 'package:app_todo_application/ListPageScreen/show_form_bottom_sheet.dart';
import 'package:app_todo_application/cubit/task_cubit.dart';
import 'package:app_todo_application/cubit/task_state.dart';
import 'package:app_todo_application/model/task_model.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPageScreen extends StatefulWidget {
  const DetailPageScreen({super.key, required this.task});
  final TaskModel task;

  @override
  State<DetailPageScreen> createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  IService _iService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        TaskModel currentTask = widget.task;
        if (state is TaskLoaded) {
          final index = state.tasks.indexWhere((d) => d.id == widget.task.id);
          if (index != -1) {
            final doc = state.tasks[index];
            currentTask = TaskModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }
        }
        return Scaffold(
          extendBody: true,
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                colors: <Color>[Color(0xFF1253AA), Color(0xFF05243E)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Text(
                          "Task Details",
                          style: AppStyles.bodyStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 76),
                    Row(
                      children: [
                        Text(currentTask.title, style: AppStyles.bodyStyle),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            showAddTaskSheet(context, task: currentTask);
                          },
                          icon: Icon(Icons.edit_note, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${currentTask.date} |",
                          style: AppStyles.bodyStyle.copyWith(fontSize: 14),
                        ),
                        Text(
                          currentTask.time,
                          style: AppStyles.bodyStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Divider(color: Colors.white, thickness: 1),
                    SizedBox(height: 25),
                    Text(
                      currentTask.description,
                      style: AppStyles.bodyStyle.copyWith(fontSize: 14),
                    ),
                    SizedBox(height: 58),
                    // các nút
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // nút done
                        GestureDetector(
                          onTap: () async {
                            // Đảo ngược trạng thái hiện tại: nếu đang true thì thành false, và ngược lại
                            bool newStatus = !currentTask.isCompleted;
                            await _iService.updateTaskStatus(
                              currentTask.id,
                              newStatus,
                            );
                            if (mounted) {
                              String message = newStatus
                                  ? "Chúc mừng! Bạn đã hoàn thành công việc."
                                  : "Đã chuyển trạng thái thành chưa hoàn thành.";
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 71,
                            width: 88,
                            decoration: BoxDecoration(
                              color: Color(0xFF0D1F33).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (currentTask.isCompleted
                                              ? Colors.green
                                              : Color(0xFF22C55E))
                                          .withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  currentTask.isCompleted
                                      ? Icons.cancel
                                      : Icons.check_circle,
                                  color: currentTask.isCompleted
                                      ? Colors.orange
                                      : Color(0xFF49EA80),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  currentTask.isCompleted ? "Undone" : "Done",
                                  style: AppStyles.bodyStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // nút deleted
                        GestureDetector(
                          onTap: () {
                            // HIỆN HỘP THOẠI XÁC NHẬN
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xFF0D1F33),
                                  title: Text(
                                    "Xác nhận xóa",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    "Bạn có chắc chắn muốn xóa công việc này không?",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "Hủy",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await _iService.deleteTask(
                                          widget.task.id,
                                        );
                                        if (mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Đã xóa công việc!",
                                              ),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        "Xóa",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 71,
                            width: 88,
                            decoration: BoxDecoration(
                              color: Color(0xFF0D1F33).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(
                                    0xFF22C55E,
                                  ).withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete, color: Color(0xFFE76666)),
                                SizedBox(height: 5),
                                Text(
                                  "Delete",
                                  style: AppStyles.bodyStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // nút pin
                        Container(
                          height: 71,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Color(0xFF0D1F33).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF22C55E).withValues(alpha: 0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.push_pin, color: Colors.yellow),
                              SizedBox(height: 5),
                              Text(
                                "Pin",
                                style: AppStyles.bodyStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
