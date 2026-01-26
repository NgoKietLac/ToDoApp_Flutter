import 'package:app_todo_application/ListPageScreen/list_page_screen.dart';
import 'package:app_todo_application/ListPageScreen/show_form_bottom_sheet.dart';
import 'package:app_todo_application/MainScreen/main_Screen.dart';
import 'package:app_todo_application/ManagerTime/manager_time_screen.dart';
import 'package:app_todo_application/SettingPageScreen/setting_page_Screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedPageIndex = 0;
  static const List<Widget> _pages = <Widget>[
    MainScreen(),
    ListPageScreen(),
    ManagerTimeScreen(),
    SettingPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _selectedPageIndex == 1
          ? SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  showAddTaskSheet(context);
                },
                backgroundColor: Color(0xFF63D9F3),
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  size: 30,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            )
          : null,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: <Color>[Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          // Tab Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Tasks',
          ),
          // Tab List
          const BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 30),
            label: "Tasks",
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
        currentIndex: _selectedPageIndex,
        selectedItemColor: Color(0xFF76D5EA),
        onTap: _onItemTapped,
      ),
    );
  }
}
