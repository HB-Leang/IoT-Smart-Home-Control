import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/views/homescreen.dart';

class RoomScreen extends StatelessWidget {
  RoomScreen({super.key});
  final DatabaseController databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Room Screen")),
      body: Center(child: Text("Room Screen")),
    );
  }
}
