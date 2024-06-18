import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/models/my_switch.dart';
import 'package:smart_home_control/widgets/control_card.dart';

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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ControlCard(
            controlName: "Balcony Light",
            mySwitch: MySwitch(
              reference: databaseController.light,
              childName: "balcony",
              initValue: databaseController.lightController.getLight("balcony"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ControlCard(
            controlName: "Garage Front Light",
            mySwitch: MySwitch(
              reference: databaseController.light,
              childName: "garageFront",
              initValue:
                  databaseController.lightController.getLight("garageFront"),
            ),
          ),
        ]),
      ),
    );
  }
}
