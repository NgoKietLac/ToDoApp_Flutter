import 'package:app_todo_application/module/data/repositories/firestore_service.dart';
import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:app_todo_application/module/presentation/cubits/task_cubit.dart';
import 'package:app_todo_application/module/presentation/screens/manager_time_screen/list_set_task_widget.dart';
import 'package:app_todo_application/module/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class ManagerTimeScreen extends StatefulWidget {
  const ManagerTimeScreen({super.key});

  @override
  State<ManagerTimeScreen> createState() => _ManagerTimeScreenState();
}

class _ManagerTimeScreenState extends State<ManagerTimeScreen> {
  DateTime today = DateTime.now();
  final taskController = TextEditingController();
  final IService _service = FirestoreService();
  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Manager Your Time",
                    style: AppStyles.headingStyle.copyWith(fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),
                // card lịch
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: TableCalendar(
                    rowHeight: 50,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(color: Colors.white),
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white),
                      weekendStyle: TextStyle(color: Colors.white),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Color(0xFF63D9F3)),
                      todayDecoration: BoxDecoration(
                        color: Color(0xFF17A1FA),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF17A1FA).withValues(alpha: 0.2),
                      ),
                    ),
                    selectedDayPredicate: (day) => isSameDay(day, today),

                    focusedDay: today,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    onDaySelected: _onDayselected,

                    onDayLongPressed: (selectedDay, focusedDay) {
                      _showTasksDialog(context, selectedDay);
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set task for " + today.toString().split(" ")[0],
                        style: GoogleFonts.inter(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D1F33),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: taskController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Task",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Nút Submit
                          ElevatedButton(
                            onPressed: () async {
                              String taskTitle = taskController.text.trim();
                              if (taskTitle.isNotEmpty) {
                                String formattedDate =
                                    "${today.day}/${today.month}/${today.year}";

                                await context.read<TaskCubit>().addNewTask(
                                  title: taskTitle,
                                  description: "Added from Calendar",
                                  date: formattedDate,
                                  time: "00:00",
                                );

                                taskController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Đã thêm công việc thành công!",
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF63D9F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              "submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDayselected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _showTasksDialog(BuildContext context, DateTime selectedDay) {
    String formattedDate =
        "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D1F33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Tasks on $formattedDate",
            style: AppStyles.headingStyle.copyWith(fontSize: 18),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListSetTaskWidget(today: selectedDay),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Close",
                style: TextStyle(color: Color(0xFF63D9F3)),
              ),
            ),
          ],
        );
      },
    );
  }
}
