import 'package:flutter/material.dart';
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
                // color: Colors.red,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Obx(
                          () => Column(
                            children: [
                              Text(
                                "First Slot",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: databaseController
                                              .sensorController.car1.value ==
                                          1
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Expanded(
                                child:
                                    databaseController
                                                .sensorController.car1.value ==
                                            1
                                        ? Image.asset(
                                            "assets/icons/parking-not-available.png")
                                        : Image.asset(
                                            "assets/icons/parking-available.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Obx(
                          () => Column(
                            children: [
                              Text(
                                "Second Slot",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: databaseController
                                              .sensorController.car2.value ==
                                          1
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Expanded(
                                child:
                                    databaseController
                                                .sensorController.car2.value ==
                                            1
                                        ? Image.asset(
                                            "assets/icons/parking-not-available.png")
                                        : Image.asset(
                                            "assets/icons/parking-available.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
