import 'package:app_todo_application/resources/font_manager.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // Kiểu chữ dành riêng cho Logo "DO IT"
  static const TextStyle logoStyle = TextStyle(
    fontFamily: AppFonts.logoFont,
    fontSize: 25,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  // Kiểu chữ tiêu đề chính trong App
  static const TextStyle headingStyle = TextStyle(
    fontFamily: AppFonts.mainFont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Kiểu chữ văn bản thông thường
  static const TextStyle bodyStyle = TextStyle(
    fontFamily: AppFonts.mainFont,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
