import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPageScreen extends StatefulWidget {
  const DetailPageScreen({super.key});

  @override
  State<DetailPageScreen> createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Text(
                      "Task Details",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 76),
                Row(
                  children: [
                    Text(
                      "team meeting",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.edit_note, color: Colors.white),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_month, size: 11, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      "Today |",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " 20:00 pm",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Divider(color: Colors.white, thickness: 1),
                SizedBox(height: 25),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 58),
                // các nút
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // nút done
                    Container(
                      height: 71,
                      width: 88,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1F33).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF22C55E,
                            ).withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF49EA80)),
                          SizedBox(height: 5),
                          Text(
                            "Done",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // nút deleted
                    Container(
                      height: 71,
                      width: 88,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1F33).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF22C55E,
                            ).withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete, color: Color(0xFFE76666)),
                          SizedBox(height: 5),
                          Text(
                            "Delete",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // nút pin
                    Container(
                      height: 71,
                      width: 88,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1F33).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF22C55E,
                            ).withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.push_pin, color: Colors.yellow),
                          SizedBox(height: 5),
                          Text(
                            "Pin",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
