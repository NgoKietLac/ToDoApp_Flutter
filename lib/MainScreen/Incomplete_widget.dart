import 'package:app_todo_application/DetailPageScreen/detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncompleteWidget extends StatelessWidget {
  const IncompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPageScreen()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15, right: 18),
              padding: const EdgeInsets.only(
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
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Tomorrow | 10:30pm",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
