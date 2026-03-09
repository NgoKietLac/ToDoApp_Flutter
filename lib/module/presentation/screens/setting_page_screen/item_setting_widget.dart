import 'package:app_todo_application/module/resources/app_styles.dart';
import 'package:flutter/material.dart';

class ItemSettingWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ItemSettingWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 15),
            Text(title, style: AppStyles.bodyStyle),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF63D9F3),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
