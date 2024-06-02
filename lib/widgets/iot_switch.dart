import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/models/my_switch.dart';

class IoTSwitch extends StatelessWidget {
  IoTSwitch({
    Key? key,
    required this.mySwitch,
    required this.activeChild,
    required this.inactiveChild,
    required this.width,
    required this.height,
    required this.borderRadius,
  }) : super(key: key);

  final MySwitch mySwitch;
  final String activeChild;
  final String inactiveChild;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  final databaseController = DatabaseController();
  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      activeColor: switchActiveColor,
      inactiveColor: swtichInactiveColor,
      activeChild: Text(activeChild),
      inactiveChild: Text(inactiveChild),
      initialValue: mySwitch.initValue.value == 1 ? true : false,
      width: width,
      height: height,
      borderRadius: borderRadius,
      // controller: _controller,
      onChanged: (value) =>
          databaseController.on_off(mySwitch.reference, mySwitch.childName),
    );
  }
}
