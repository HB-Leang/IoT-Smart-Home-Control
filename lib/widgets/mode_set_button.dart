import 'package:flutter/material.dart';

class ModeSetButton extends StatelessWidget {
  const ModeSetButton({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              blurRadius: 10, color: Colors.blue.shade200, spreadRadius: 2)
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue.shade400,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
