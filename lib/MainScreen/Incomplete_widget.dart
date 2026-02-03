import 'package:app_todo_application/DetailPageScreen/detail_page_screen.dart';
import 'package:app_todo_application/cubit/task_cubit.dart';
import 'package:app_todo_application/cubit/task_state.dart';
import 'package:app_todo_application/model/task_model.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncompleteWidget extends StatelessWidget {
  const IncompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            final incompleteTasks = state.tasks.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return data['isCompleted'] == false;
            }).toList();

            if (incompleteTasks.isEmpty) {
              return Center(
                child: Text(
                  "Không có công việc chưa xong",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: incompleteTasks.length,
              itemBuilder: (context, index) {
                final taskData =
                    incompleteTasks[index].data() as Map<String, dynamic>;
                final task = TaskModel.fromMap(
                  taskData,
                  incompleteTasks[index].id,
                );

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPageScreen(task: task),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15, right: 18),
                    padding: EdgeInsets.only(
                      top: 12,
                      right: 25,
                      bottom: 10,
                      left: 25,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: AppStyles.bodyStyle.copyWith(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${task.date} | ${task.time}",
                              style: AppStyles.bodyStyle.copyWith(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                          color: Color(0xFF0EA5E9),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator(color: Colors.white));
        },
      ),
    );
  }
}
