import 'package:app_todo_application/DetailPageScreen/detail_page_screen.dart';
import 'package:app_todo_application/ListPageScreen/show_form_bottom_sheet.dart';
import 'package:app_todo_application/MainScreen/main_Screen.dart';
import 'package:app_todo_application/ManagerTime/manager_time_screen.dart';
import 'package:app_todo_application/SettingPageScreen/setting_page_Screen.dart';
import 'package:app_todo_application/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPageScreen extends StatefulWidget {
  const ListPageScreen({super.key});

  @override
  State<ListPageScreen> createState() => _ListPageScreenState();
}

class _ListPageScreenState extends State<ListPageScreen> {
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
        child: Container(
          margin: EdgeInsets.only(top: 45, left: 18, right: 9),
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
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search by task title",
                          hintStyle: AppStyles.bodyStyle.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none, // Xóa gạch chân mặc định
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
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
                        Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      ],
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
              SizedBox(
                height: 327,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPageScreen(),
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
                                  "Client meeting",
                                  style: AppStyles.bodyStyle.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Tomorrow | 10:30pm",
                                  style: AppStyles.headingStyle.copyWith(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
