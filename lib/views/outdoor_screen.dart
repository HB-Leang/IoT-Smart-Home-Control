import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
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
            Obx(
              () => LiteRollingSwitch(
                value: databaseController.lightController.garage.value == 1
                    ? true
                    : false,
                width: 150,
                textOn: 'active',
                textOff: 'inactive',
                colorOn: Colors.deepOrange,
                colorOff: Colors.blueGrey,
                iconOn: Icons.lightbulb_outline,
                iconOff: Icons.power_settings_new,
                animationDuration: const Duration(milliseconds: 300),
                onChanged: (bool state) {
                  // print('turned ${(state) ? 'on' : 'off'}');
                  // print(databaseController.lightController
                  //     .getLight("garage")
                  //     .value);
                },
                onDoubleTap: () {},
                onSwipe: () {},
                onTap: () async {
                  await databaseController.on_off(
                      databaseController.light, "garage");
                },
              ),
            ),
            Obx(
              () => CupertinoSwitch(
                value: databaseController.lightController.garage.value == 1
                    ? true
                    : false,
                onChanged: (state) {},
              ),
            ),
            GetBuilder(
              init: DatabaseController(),
              builder: (controller) {
                // var _controller = ValueNotifier<bool>(
                //   controller.lightController.garage.value == 1 ? true : false,
                // );
                var _controller = controller.lightController.garage.value == 1
                    ? ValueNotifier<bool>(true)
                    : ValueNotifier<bool>(false);
                return AdvancedSwitch(
                  controller: _controller,
                  activeColor: switchActiveColor,
                  inactiveColor: swtichInactiveColor,
                  activeChild: Text(
                    "On",
                    style: const TextStyle(fontSize: 12),
                  ),
                  inactiveChild: Text(
                    "Off",
                    style: const TextStyle(fontSize: 12),
                  ),
                  thumb: ValueListenableBuilder<bool>(
                    valueListenable: _controller,
                    builder: (_, value, __) {
                      return Icon(
                          value ? Icons.lightbulb : Icons.lightbulb_outline);
                    },
                  ),

                  initialValue: controller.lightController.garage.value == 1
                      ? true
                      : false,
                  width: 90,
                  height: 40,
                  borderRadius: BorderRadius.circular(20),
                  // controller: _controller,
                  onChanged: (value) async {
                    // await databaseController.on_off(
                    //     mySwitch.reference, mySwitch.childName);
                    // initValue.value = mySwitch.initValue.value == 1 ? true : false;
                    // print("value : $value");
                    // print(initValue.value);
                    // print(mySwitch.initValue.value);
                  },
                );
              },
            ),
            Obx(
              () => FlutterSwitch(
                width: 90.0,
                height: 40.0,
                valueFontSize: 12.0,
                toggleSize: 25.0,
                value: databaseController.lightController.garage.value == 1
                    ? true
                    : false,
                borderRadius: 30.0,
                padding: 5.0,
                showOnOff: true,
                activeText: "OPEN",
                inactiveText: "CLOSE",
                onToggle: (val) {
                  databaseController.on_off(databaseController.light, "garage");
                },
              ),
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
