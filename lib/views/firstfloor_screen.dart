import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';

import '../models/my_switch.dart';
import '../models/size.dart';
import '../widgets/control_card.dart';

class FirstFloorScreen extends StatelessWidget {
  FirstFloorScreen({super.key});
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
                controlName: "First Floor Light",
                width: switchSize['light']!['width']!,
                height: switchSize['light']!['height']!,
                toggleSize: switchSize['light']!['toggleSize'],
                mySwitch: MySwitch(
                  reference: databaseController.light,
                  childName: "firstFloor",
                  initValue:
                      databaseController.lightController.getLight("firstFloor"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ControlCard(
                controlName: "Window",
                mySwitch: MySwitch(
                  reference: databaseController.actuators,
                  childName: "window",
                  initValue: databaseController.actuatorController.window,
                ),
                activeImage: 'assets/icons/window3-open.png',
                inactiveImage: 'assets/icons/window3-close.png',
                activeChild: "OPEN",
                inactiveChild: "CLOSE",
                width: switchSize['door']!['width']!,
                height: switchSize['door']!['height']!,
                toggleSize: switchSize['door']!['toggleSize']!,
              ),
            ],
          )
        ],
      ),
    );
  }
}
