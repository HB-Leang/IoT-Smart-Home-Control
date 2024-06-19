import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/models/my_switch.dart';
import 'package:smart_home_control/widgets/control_card.dart';

import '../models/size.dart';

class OutdoorScreen extends StatelessWidget {
  OutdoorScreen({super.key});
  final DatabaseController databaseController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Outdoor",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ControlCard(
                  controlName: "Front Door Light",
                  width: switchSize['light']!['width']!,
                  height: switchSize['light']!['height']!,
                  toggleSize: switchSize['light']!['toggleSize'],
                  mySwitch: MySwitch(
                    reference: databaseController.light,
                    childName: "frontDoor",
                    initValue: databaseController.lightController
                        .getLight("frontDoor"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ControlCard(
                  controlName: "Balcony Light",
                  width: switchSize['light']!['width']!,
                  height: switchSize['light']!['height']!,
                  toggleSize: switchSize['light']!['toggleSize'],
                  mySwitch: MySwitch(
                    reference: databaseController.light,
                    childName: "balcony",
                    initValue:
                        databaseController.lightController.getLight("balcony"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ControlCard(
                  controlName: "Garage Front Light",
                  width: switchSize['light']!['width']!,
                  height: switchSize['light']!['height']!,
                  toggleSize: switchSize['light']!['toggleSize'],
                  mySwitch: MySwitch(
                    reference: databaseController.light,
                    childName: "garageFront",
                    initValue: databaseController.lightController
                        .getLight("garageFront"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ControlCard(
                  controlName: "Garage",
                  width: switchSize['door']!['width']!,
                  height: switchSize['door']!['height']!,
                  toggleSize: switchSize['door']!['toggleSize'],
                  activeChild: "OPEN",
                  inactiveChild: "CLOSE",
                  activeImage: "assets/icons/garage-open.png",
                  inactiveImage: "assets/icons/garage-close.png",
                  mySwitch: MySwitch(
                    reference: databaseController.actuators,
                    childName: "door/garage",
                    initValue:
                        databaseController.actuatorController.getDoor("garage"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
