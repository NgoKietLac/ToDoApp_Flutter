import 'package:app_todo_application/module/data/repositories/firestore_service.dart';
import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:app_todo_application/module/presentation/screens/list_page_screen/list_page_screen.dart';
import 'package:app_todo_application/module/presentation/screens/list_page_screen/show_form_bottom_sheet.dart';
import 'package:app_todo_application/module/presentation/screens/main_screen/main_Screen.dart';
import 'package:app_todo_application/module/presentation/screens/manager_time_screen/manager_time_screen.dart';
import 'package:app_todo_application/module/presentation/screens/setting_page_screen/setting_page_Screen.dart';
import 'package:app_todo_application/module/presentation/cubits/auth_cubit.dart';
import 'package:app_todo_application/module/presentation/cubits/auth_state.dart';
import 'package:app_todo_application/module/presentation/cubits/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  IService _service = FirestoreService();
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthCubit>().state is Authenticated) {
        context.read<TaskCubit>().loadTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.read<TaskCubit>().loadTasks();
        }
      },
      child: Scaffold(
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
              label: 'Home',
            ),
            // Tab List
            BottomNavigationBarItem(
              icon: Icon(Icons.list, size: 30),
              label: "Tasks",
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
          currentIndex: _selectedPageIndex,
          selectedItemColor: Color(0xFF76D5EA),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
