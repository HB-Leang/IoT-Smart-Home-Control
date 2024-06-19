import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';

import '../models/my_switch.dart';
import '../models/size.dart';
import '../widgets/control_card.dart';

class GarageScreen extends StatelessWidget {
  GarageScreen({super.key});
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
                controlName: "Garage Light",
                width: switchSize['light']!['width']!,
                height: switchSize['light']!['height']!,
                toggleSize: switchSize['light']!['toggleSize'],
                mySwitch: MySwitch(
                  reference: databaseController.light,
                  childName: "garage",
                  initValue: databaseController.lightController.garage,
                ),
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
