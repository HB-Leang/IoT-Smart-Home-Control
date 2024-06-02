import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/views/rooms_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController databaseController = Get.put(DatabaseController());
    final DatabaseReference dataBase = FirebaseDatabase.instance.ref();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "IoT Demo",
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: MediaQuery.sizeOf(context).height * 0.8,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Group3 Smart Home",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sunny,
                      size: 60,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Cloudy Day",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Obx(
                          () => Text(
                            "${databaseController.sensorController.temp.value} C",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        Text(
                          "Temperature",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Obx(
                          () => Text(
                            "${databaseController.sensorController.hum.value}",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        Text(
                          "Humidity",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  color: Colors.blue,
                  child: Text("lsdkfj"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  color: Colors.red,
                  child: Text("lsdkfj"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
