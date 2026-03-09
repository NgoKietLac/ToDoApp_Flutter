import 'package:app_todo_application/module/presentation/screens/setting_page_screen/detail_profile_screen.dart';
import 'package:app_todo_application/module/presentation/screens/setting_page_screen/item_setting_widget.dart';
import 'package:app_todo_application/module/presentation/screens/sign_in_screen/sign_in_screen.dart';
import 'package:app_todo_application/module/presentation/cubits/auth_cubit.dart';
import 'package:app_todo_application/module/presentation/cubits/task_cubit.dart';
import 'package:app_todo_application/module/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({super.key});

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {
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
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Setting",
                  style: AppStyles.headingStyle.copyWith(fontSize: 25),
                ),
              ),
              SizedBox(height: 104),
              //thẻ profile
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: ItemSettingWidget(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProfileScreen(),
                      ),
                    );
                  },
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              //thẻ conver
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: ItemSettingWidget(
                  icon: Icons.chat_bubble,
                  title: "Converstations",
                  onTap: () {},
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: ItemSettingWidget(
                  icon: Icons.lightbulb,
                  title: "Projects",
                  onTap: () {},
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: ItemSettingWidget(
                  icon: Icons.find_in_page,
                  title: "Terms and Policies",
                  onTap: () {},
                ),
              ),
              Divider(color: Colors.white24, indent: 25, endIndent: 25),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TaskCubit>().clearTasks();
                    context.read<AuthCubit>().logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.logout, color: Colors.red),
                      const SizedBox(width: 10),
                      Text(
                        "Logout",
                        style: AppStyles.bodyStyle.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
