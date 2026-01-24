import 'package:app_todo_application/ListPageScreen/list_page_screen.dart';
import 'package:app_todo_application/MainScreen/Incomplete_widget.dart';
import 'package:app_todo_application/MainScreen/avatar_stack.dart';
import 'package:app_todo_application/MainScreen/complete_widget.dart';
import 'package:app_todo_application/ManagerTime/manager_time_screen.dart';
import 'package:app_todo_application/SettingPageScreen/setting_page_Screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: <Color>[Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 27, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/icon/appbarmain_icon.png"),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "oussama chahidi",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "oussamachahidi@gmail.com",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.notifications_sharp,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  "Group tasks",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              CarouselSlider(
                items: [
                  //item 1
                  Container(
                    margin: EdgeInsets.only(top: 16, right: 15, left: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, left: 23),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Design Meeting",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Tomorrow | 10:30pm",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 9),
                          AvatarStack(),
                        ],
                      ),
                    ),
                  ),
                  //item 2
                  Container(
                    margin: EdgeInsets.only(top: 16, right: 15, left: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, left: 23),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Projects Meeting",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Thursday | 10:30pm",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 9),
                          AvatarStack(),
                        ],
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 160,
                  viewportFraction: 0.6,
                  padEnds: false,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.horizontal,
                  disableCenter: true,
                ),
              ),
              SizedBox(height: 19),
              Text(
                "Incomplete Tasks",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 17),
              IncompleteWidget(),
              SizedBox(height: 12),
              Text(
                "Completed Tasks",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              CompleteWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPageScreen()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManagerTimeScreen()),
            );
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingPageScreen()),
            );
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF76D5EA).withValues(alpha: 25),
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          // Tab Home
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined, size: 30),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.home, size: 30),
                const SizedBox(height: 4),
                Container(
                  width: 15,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
            label: 'Home',
          ),
          // Tab List
          const BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 30),
            label: 'Tasks',
          ),
          // Tab Calendar
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined, size: 28),
            label: 'Calendar',
          ),
          // Tab Settings
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 30),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
