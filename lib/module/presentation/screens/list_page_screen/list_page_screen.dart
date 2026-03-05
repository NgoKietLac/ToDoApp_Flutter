import 'package:app_todo_application/module/presentation/screens/detail_page_screen/detail_page_screen.dart';
import 'package:app_todo_application/module/data/repositories/firestore_service.dart';
import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:app_todo_application/module/data/models/task_model.dart';
import 'package:app_todo_application/module/presentation/cubits/task_cubit.dart';
import 'package:app_todo_application/module/presentation/cubits/task_state.dart';
import 'package:app_todo_application/module/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPageScreen extends StatefulWidget {
  const ListPageScreen({super.key});

  @override
  State<ListPageScreen> createState() => _ListPageScreenState();
}

class _ListPageScreenState extends State<ListPageScreen> {
  IService _service = FirestoreService();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
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
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 45, left: 18, right: 9, bottom: 5),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: Color(0xFF1A2F4B),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              taskCubit.updateSearch(value);
                            },
                            controller: searchController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Search by task title",
                              hintStyle: AppStyles.bodyStyle.copyWith(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border:
                                  InputBorder.none, // Xóa gạch chân mặc định
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          taskCubit.updateSort(value);
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'Newest',
                            child: Text("Mới nhất"),
                          ),
                          PopupMenuItem(
                            value: 'Alpha',
                            child: Text("Tên (A-Z)"),
                          ),
                        ],
                        child: Container(
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFF1A2F4B),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.sort, color: Colors.grey, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "Sort By:",
                                style: AppStyles.bodyStyle.copyWith(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 46),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Tasks List",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 490,
                    child: BlocBuilder<TaskCubit, TaskState>(
                      builder: (context, state) {
                        if (state is TaskLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        if (state is TaskError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        if (state is TaskLoaded) {
                          final tasks = state.filteredTasks;

                          if (tasks.isEmpty) {
                            return Center(
                              child: Text(
                                "Không có công việc phù hợp",
                                style: AppStyles.bodyStyle,
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPageScreen(task: task),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: 15,
                                    right: 18,
                                  ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          if (task.isCompleted)
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 25,
                                              ),
                                            ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                task.title,
                                                style: AppStyles.bodyStyle
                                                    .copyWith(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              Text(
                                                "${task.date} | ${task.time}",
                                                style: AppStyles.headingStyle
                                                    .copyWith(
                                                      fontSize: 10,
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
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF0EA5E9),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
