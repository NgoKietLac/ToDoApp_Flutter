import 'package:app_todo_application/FirestoreService/firestore_service.dart';
import 'package:app_todo_application/FirestoreService/service.dart';
import 'package:app_todo_application/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAddTaskSheet(BuildContext context, {TaskModel? task}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (BuildContext context) {
      return ShowFormBottomSheet(task: task);
    },
  );
}

class ShowFormBottomSheet extends StatefulWidget {
  final TaskModel? task;
  const ShowFormBottomSheet({super.key, required this.task});

  @override
  State<ShowFormBottomSheet> createState() => _ShowFormBottomSheetState();
}

class _ShowFormBottomSheetState extends State<ShowFormBottomSheet> {
  final IService _service = FirestoreService();
  final taskController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      taskController.text = widget.task!.title;
      descController.text = widget.task!.description;
      dateController.text = widget.task!.date;
      timeController.text = widget.task!.time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 27,
          right: 27,
          top: 20,
        ),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 54),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF05243E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "mời bạn nhập tiêu đề";
                      }
                      return null;
                    },
                    controller: taskController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "task",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.check_box_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 34),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF05243E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 14),
                      child: Icon(Icons.menu, color: Colors.white),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "mời bạn nhập mô tả";
                          }
                          return null;
                        },
                        controller: descController,
                        maxLines: 5,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Row(
                children: [
                  // Ô Date
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF05243E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: Color(
                                      0xFF63D9F3,
                                    ), // Màu của vòng tròn chọn ngày và tiêu đề
                                    onPrimary: Colors
                                        .black, // Màu chữ bên trong vòng tròn chọn
                                    surface: Color(
                                      0xFF05243E,
                                    ), // Màu nền của bảng lịch
                                    onSurface: Colors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          print('Date: $selectedDate');
                          if (selectedDate != null) {
                            setState(() {
                              dateController.text =
                                  selectedDate.day.toString() +
                                  "/" +
                                  selectedDate.month.toString() +
                                  "/" +
                                  selectedDate.year.toString();
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "mời bạn nhập ngày";
                          }
                          return null;
                        },
                        controller: dateController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Date",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  // Ô Time
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF05243E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: Color(
                                      0xFF63D9F3,
                                    ), // Màu của kim đồng hồ và số đang chọn
                                    onPrimary: Colors
                                        .black, // Màu chữ trên kim đồng hồ
                                    surface: Color(
                                      0xFF05243E,
                                    ), // Màu nền hộp thoại
                                    onSurface:
                                        Colors.white, // Màu của các con số giờ
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          print('date : $selectedTime');
                          if (selectedTime != null) {
                            setState(() {
                              timeController.text =
                                  selectedTime.hour.toString() +
                                  ":" +
                                  selectedTime.minute.toString();
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "mời bạn nhập giờ";
                          }
                          return null;
                        },
                        controller: timeController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Time",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Row(
                  children: [
                    // Nút Cancel
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Color(0xFF63D9F3),
                          ), // Viền xanh cyan
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "cancel",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF05243E),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    // Nút Create
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            if (widget.task == null) {
                              _service.addTask(
                                title: taskController.text,
                                description: descController.text,
                                date: dateController.text,
                                time: timeController.text,
                              );
                            } else {
                              _service.updateTask(
                                widget.task!.id,
                                title: taskController.text,
                                description: descController.text,
                                date: dateController.text,
                                time: timeController.text,
                              );
                            }
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF63D9F3),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          widget.task == null ? "create" : "update",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    descController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
