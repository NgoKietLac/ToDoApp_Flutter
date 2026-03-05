import 'package:app_todo_application/module/presentation/cubits/task_cubit.dart';
import 'package:app_todo_application/module/presentation/cubits/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListSetTaskWidget extends StatelessWidget {
  const ListSetTaskWidget({super.key, required this.today});

  final DateTime today;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            String formattedDate = "${today.day}/${today.month}/${today.year}";
            final dayTasks = state.tasks.where((task) {
              return task.date == formattedDate;
            }).toList();

            if (dayTasks.isEmpty) {
              return const Center(
                child: Text(
                  "Không có task cho ngày này",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.builder(
              itemCount: dayTasks.length,
              itemBuilder: (context, index) {
                final task = dayTasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    task.time,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  leading: Icon(
                    task.isCompleted == true
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: Colors.cyanAccent,
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
