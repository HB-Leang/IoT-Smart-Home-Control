import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';

import '../models/my_switch.dart';
import '../models/size.dart';
import '../widgets/control_card.dart';

class KitchenScreen extends StatelessWidget {
  KitchenScreen({super.key});
  final DatabaseController databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              ControlCard(
                controlName: "Kitchen Light",
                width: switchSize['light']!['width']!,
                height: switchSize['light']!['height']!,
                toggleSize: switchSize['light']!['toggleSize'],
                mySwitch: MySwitch(
                  reference: databaseController.light,
                  childName: "kitchen",
                  initValue:
                      databaseController.lightController.getLight("kitchen"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ControlCard(
                controlName: "Kitchen Fan",
                mySwitch: MySwitch(
                  reference: databaseController.actuators,
                  childName: "fan/kitchen",
                  initValue:
                      databaseController.actuatorController.getFan("kitchen"),
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
            ],
          ),
        ],
      ),
    );
  }
}
