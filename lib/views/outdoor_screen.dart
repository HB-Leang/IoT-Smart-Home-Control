import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:riff_switch/riff_switch.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/models/my_switch.dart';
import 'package:smart_home_control/views/homescreen.dart';
import 'package:smart_home_control/widgets/control_card.dart';
import 'package:smart_home_control/widgets/iot_switch.dart';
import 'package:smart_home_control/widgets/light_switch.dart';

class OutdoorScreen extends StatelessWidget {
  OutdoorScreen({super.key});
  final DatabaseController databaseController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    // final _controller = ValueNotifier<bool>(
    //     databaseController.lightController.livingRoom.value == 1
    //         ? true
    //         : false);

    // final _controller = ValueNotifier(false);

    return Scaffold(
      appBar: AppBar(title: Text("Outdoor Screen")),
      body: Center(
        child: Column(
          children: [
            ControlCard(
              controlName: "Bedroom Door",
              activeImage: "assets/icons/door-open.png",
              inactiveImage: "assets/icons/door-close.png",
              activeChild: "OPEN",
              inactiveChild: "CLOSE",
              width: 100,
              mySwitch: MySwitch(
                  reference: databaseController.actuators,
                  childName: 'door/bedRoom1',
                  initValue: databaseController.actuatorController
                      .getDoor('bedRoom1')),
            ),
            SizedBox(
              height: 30,
            ),
            ControlCard(
              controlName: "Garage Light",
              mySwitch: MySwitch(
                reference: databaseController.light,
                childName: "garage",
                initValue: databaseController.lightController.garage,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ControlCard(
              controlName: "Garage Door",
              mySwitch: MySwitch(
                reference: databaseController.actuators,
                childName: "door/garage",
                initValue:
                    databaseController.actuatorController.getDoor('garage'),
              ),
              activeImage: 'assets/icons/garage-open.png',
              inactiveImage: 'assets/icons/garage-close.png',
              activeChild: "OPEN",
              inactiveChild: "CLOSE",
              width: 100,
            ),
          ],
        ),

        // Obx(
        //     () => AdvancedSwitch(
        //       activeColor: switchActiveColor,
        //       inactiveColor: swtichInactiveColor,
        //       activeChild: Text("ON"),
        //       inactiveChild: Text("OFF"),
        //       initialValue:
        //           databaseController.lightController.livingRoom.value == 1
        //               ? true
        //               : false,
        //       width: 80,
        //       // controller: _controller,
        //       onChanged: (value) => databaseController.lightController
        //           .led_on_off(databaseController.light, "livingRoom"),
        //     ),
        //   ),
        // body: Center(
        //   child: Obx(
        //     () => RiffSwitch(
        //       value: databaseController.lightController.livingRoom.value == 1
        //           ? true
        //           : false,
        //       onChanged: (value) {
        //         databaseController.lightController
        //             .led_on_off(databaseController.light, "livingRoom");
        //       },
        //       type: RiffSwitchType.decorative,
        //       activeChild: const Card(
        //         color: CupertinoColors.systemTeal,
        //         child: Icon(Icons.lightbulb),
        //       ),
        //       activeColor: Colors.red,
        //       inactiveThumbColor: Colors.teal,
        //       inactiveChild: const Card(
        //         color: CupertinoColors.systemYellow,
        //         child: Icon(Icons.lightbulb),
        //       ),
        //       height: 60,
        //       width: 120,
        //       borderWidth: 1,
        //       thumbMargin: 5,
        //       borderRadius: 8,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
