import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  const AvatarStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 100,
      child: Stack(
        children: [
          //hình 1
          Positioned(
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage("assets/icon/user1.png"),
              ),
            ),
          ),
          //hình 2
          Positioned(
            left: 18,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage("assets/icon/user2.png"),
              ),
            ),
          ),
          Positioned(
            left: 36,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage("assets/icon/user3.png"),
              ),
            ),
          ),
          // btn cộng
          Positioned(
            left: 54,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.add, size: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
