import 'package:app_todo_application/module/presentation/screens/detail_page_screen/detail_page_screen.dart';
import 'package:app_todo_application/module/data/models/task_model.dart';
import 'package:app_todo_application/module/presentation/cubits/task_cubit.dart';
import 'package:app_todo_application/module/presentation/cubits/task_state.dart';
import 'package:app_todo_application/module/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteWidget extends StatelessWidget {
  const CompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            final completedTasks = state.tasks.where((task) {
              return task.isCompleted == true;
            }).toList();

            if (completedTasks.isEmpty) {
              return Center(
                child: Text(
                  "Ko có công việc hoàn thành",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];

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
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 25,
                            ),
                            SizedBox(width: 9),
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
