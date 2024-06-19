import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';

import '../models/my_switch.dart';
import '../models/size.dart';
import '../widgets/control_card.dart';

class BedRoom2Screen extends StatelessWidget {
  BedRoom2Screen({super.key});
  final DatabaseController databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        children: [
          Column(
            children: [
              ControlCard(
                controlName: "Bedroom Light",
                width: switchSize['light']!['width']!,
                height: switchSize['light']!['height']!,
                toggleSize: switchSize['light']!['toggleSize'],
                mySwitch: MySwitch(
                  reference: databaseController.light,
                  childName: "bedRoom2",
                  initValue:
                      databaseController.lightController.getLight("bedRoom2"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ControlCard(
                controlName: "Bedroom Fan",
                mySwitch: MySwitch(
                  reference: databaseController.actuators,
                  childName: "fan/bedRoom2",
                  initValue:
                      databaseController.actuatorController.getFan("bedRoom2"),
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
                    childName: 'door/bedRoom2',
                    initValue: databaseController.actuatorController
                        .getDoor('bedRoom2')),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}
