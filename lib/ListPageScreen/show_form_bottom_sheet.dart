import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAddTaskSheet(BuildContext context, {onSave}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (BuildContext context) {
      return ShowFormBottomSheet();
    },
  );
}

class ShowFormBottomSheet extends StatefulWidget {
  const ShowFormBottomSheet({super.key});

  @override
  State<ShowFormBottomSheet> createState() => _ShowFormBottomSheetState();
}

class _ShowFormBottomSheetState extends State<ShowFormBottomSheet> {
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
                child: TextField(
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
                    child: TextField(
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
                    child: TextField(
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
                    child: const TextField(
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
                        // Xử lý tạo task ở đây
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF63D9F3), // Nền xanh cyan
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "create",
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
    );
  }
}
