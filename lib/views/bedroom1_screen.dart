import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';

import '../models/my_switch.dart';
import '../models/size.dart';
import '../widgets/control_card.dart';

class BedRoom1Screen extends StatelessWidget {
  BedRoom1Screen({super.key});
  final DatabaseController databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                ControlCard(
                  controlName: "Bedroom Light",
                  width: switchSize['light']!['width']!,
                  height: switchSize['light']!['height']!,
                  toggleSize: switchSize['light']!['toggleSize'],
                  mySwitch: MySwitch(
                    reference: databaseController.light,
                    childName: "bedRoom1",
                    initValue:
                        databaseController.lightController.getLight("bedRoom1"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ControlCard(
                  controlName: "Bedroom Fan",
                  mySwitch: MySwitch(
                    reference: databaseController.actuators,
                    childName: "fan/bedRoom1",
                    initValue: databaseController.actuatorController
                        .getFan("bedRoom1"),
                  ),
                  // activeImage: 'assets/icons/garage-open.png',
                  // inactiveImage: 'assets/icons/garage-close.png',
                  activeChild: "ON",
                  inactiveChild: "OFF",
                  width: switchSize['light']!['width']!,
                  height: switchSize['light']!['height']!,
                  toggleSize: switchSize['light']!['toggleSize']!,
                  isFan: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                ControlCard(
                  controlName: "Bedroom Door",
                  activeImage: "assets/icons/door-open.png",
                  inactiveImage: "assets/icons/door-close.png",
                  activeChild: "OPEN",
                  inactiveChild: "CLOSE",
                  width: switchSize['door']!['width']!,
                  height: switchSize['door']!['height']!,
                  toggleSize: switchSize['door']!['toggleSize'],
                  mySwitch: MySwitch(
                      reference: databaseController.actuators,
                      childName: 'door/bedRoom1',
                      initValue: databaseController.actuatorController
                          .getDoor('bedRoom1')),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
