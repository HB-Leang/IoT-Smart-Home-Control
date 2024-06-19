import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/models/my_switch.dart';
import 'package:smart_home_control/models/size.dart';
import 'package:smart_home_control/widgets/control_card.dart';

class LivingRoom extends StatelessWidget {
  LivingRoom({super.key});
  final DatabaseController databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                ControlCard(
                  controlName: "Living Room Light",
                  width: switchSize['light']!['width']!,
                  height: switchSize['light']!['height']!,
                  toggleSize: switchSize['light']!['toggleSize'],
                  mySwitch: MySwitch(
                    reference: databaseController.light,
                    childName: "livingRoom",
                    initValue: databaseController.lightController
                        .getLight("livingRoom"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ControlCard(
                  controlName: "Curtain",
                  mySwitch: MySwitch(
                    reference: databaseController.actuators,
                    childName: "curtain",
                    initValue: databaseController.actuatorController.curtain,
                  ),
                  activeImage: 'assets/icons/curtain3-open.png',
                  inactiveImage: 'assets/icons/curtain-close.png',
                  activeChild: "OPEN",
                  inactiveChild: "CLOSE",
                  width: switchSize['door']!['width']!,
                  height: switchSize['door']!['height']!,
                  toggleSize: switchSize['door']!['toggleSize']!,
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
