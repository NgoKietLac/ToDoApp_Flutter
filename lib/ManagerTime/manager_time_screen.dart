import 'package:app_todo_application/ListPageScreen/list_page_screen.dart';
import 'package:app_todo_application/MainScreen/main_Screen.dart';
import 'package:app_todo_application/SettingPageScreen/setting_page_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerTimeScreen extends StatefulWidget {
  const ManagerTimeScreen({super.key});

  @override
  State<ManagerTimeScreen> createState() => _ManagerTimeScreenState();
}

class _ManagerTimeScreenState extends State<ManagerTimeScreen> {
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Manage Your Time",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              // card lịch
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF63D9F3),
                          size: 16,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "January",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF63D9F3),
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Hàng tên các thứ trong tuần
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
                          .map(
                            (day) => Text(
                              day,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    // Lưới các ngày (GridView)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                      itemCount: 31,
                      itemBuilder: (context, index) {
                        int day = index + 1;
                        bool isSelected = day == 20;
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF63D9F3)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "$day",
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
                      "Set task for 20 January 2023",
                      style: GoogleFonts.inter(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        // Ô nhập Task
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D1F33),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const TextField(
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
                          onPressed: () {},
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPageScreen()),
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
            icon: Icon(Icons.home_outlined, size: 30),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, size: 30),
                SizedBox(height: 4),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 30),
            label: 'Tasks',
          ),
          // Tab Calendar
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined, size: 28),
            label: 'Calendar',
          ),
          // Tab Settings
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 30),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
