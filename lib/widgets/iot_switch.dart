import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/models/my_switch.dart';

class IoTSwitch extends StatelessWidget {
  IoTSwitch({
    Key? key,
    required this.mySwitch,
    required this.activeChild,
    required this.inactiveChild,
    required this.toggleSize,
    required this.width,
    required this.height,
    required this.borderRadius,
  }) : super(key: key);

  final MySwitch mySwitch;
  final String activeChild;
  final String inactiveChild;
  final double? toggleSize;
  final double width;
  final double height;
  final double borderRadius;

  final databaseController = DatabaseController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterSwitch(
        width: width,
        height: height,
        valueFontSize: 12.0,
        toggleSize: toggleSize ?? 25.0,
        value: mySwitch.initValue.value == 1 ? true : false,
        borderRadius: borderRadius,
        padding: 5.0,
        showOnOff: true,
        activeText: activeChild,
        inactiveText: inactiveChild,
        onToggle: (val) async {
          await databaseController.on_off(
              mySwitch.reference, mySwitch.childName);
        },
      ),
    );
    // return Obx(
    //   () => AdvancedSwitch(
    //       controller: mySwitch.initValue.value == 1
    //           ? ValueNotifier(true)
    //           : ValueNotifier(false),
    //       activeColor: switchActiveColor,
    //       inactiveColor: swtichInactiveColor,
    //       activeChild: Text(
    //         activeChild,
    //         style: const TextStyle(fontSize: 12),
    //       ),
    //       inactiveChild: Text(
    //         inactiveChild,
    //         style: const TextStyle(fontSize: 12),
    //       ),
    //       // initialValue: mySwitch.initValue.value == 1 ? true : false,
    //       width: width,
    //       height: height,
    //       borderRadius: borderRadius,
    //       // controller: _controller,
    //       onChanged: (value) async {
    //         await databaseController.on_off(
    //             mySwitch.reference, mySwitch.childName);
    //         initValue.value = mySwitch.initValue.value == 1 ? true : false;
    //         print("value : $value");
    //         print(initValue.value);
    //         print(mySwitch.initValue.value);
    //       }),
    // );
  }
}
