import 'package:app_todo_application/cubit/task_cubit.dart';
import 'package:app_todo_application/cubit/task_state.dart';
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
            final dayTasks = state.tasks.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return data['date'] == formattedDate;
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
                final data = dayTasks[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(
                    data['title'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    data['time'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                  leading: Icon(
                    data['isCompleted'] == true
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
