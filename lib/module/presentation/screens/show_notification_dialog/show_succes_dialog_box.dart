import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSuccesDialogBox extends StatelessWidget {
  const ShowSuccesDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Color(0xFFC8E6C9),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded, size: 70, color: Colors.green),
            ),
            SizedBox(height: 17),
            SizedBox(
              child: Column(
                children: [
                  Text(
                    "Your account has been created successfully",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Text(
                    "You gonna recieve a verification code in your email",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
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
