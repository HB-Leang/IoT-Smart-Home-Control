import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorConnect extends StatelessWidget {
  const ErrorConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Failed to establish connection with firebase"),
      ),
    );
  }
}
