import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/actuator_controller.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/controllers/light_controller.dart';
import 'package:smart_home_control/controllers/sensor_controller.dart';
import 'package:smart_home_control/models/color.dart';

Widget lightSwitch(
    {required LightController controller, required String child}) {
  return Obx(
    () => AdvancedSwitch(
      activeColor: switchActiveColor,
      inactiveColor: swtichInactiveColor,
      activeChild: Text("ON"),
      inactiveChild: Text("OFF"),
      initialValue: controller.getLight(child).value == 1 ? true : false,
      width: 80,
      // controller: _controller,
      onChanged: (value) => controller.led_on_off(controller.lightPath, child),
    ),
  );
}

// Widget iotSwitch({
//   required DatabaseReference dbRef,
//   required String childName,
// }) {
//   return Obx(() => AdvancedSwitch(
//         activeColor: switchActiveColor,
//         inactiveColor: swtichInactiveColor,
//         activeChild: Text("ON"),
//         inactiveChild: Text("OFF"),
//         initialValue:
//             databaseController.actuatorController.getDoor('balcony').value == 1
//                 ? true
//                 : false,
//         width: 80,
//         // controller: _controller,
//         onChanged: (value) =>
//             databaseController.on_off(databaseController.light, "balcony"),
//       ));
// }

Widget testSwitch({required DatabaseReference ref, required String child}) {
  final DatabaseController dbController = Get.put(DatabaseController());
  final db = ref.child(child);
  final snapshot = db.get();

  return Obx(
    () => AdvancedSwitch(
      activeColor: switchActiveColor,
      inactiveColor: swtichInactiveColor,
      activeChild: Text("ON"),
      inactiveChild: Text("OFF"),
      initialValue: snapshot == 1 ? true : false,
      width: 80,
      // controller: _controller,
      onChanged: (value) => dbController.on_off(ref, child),
    ),
  );
  // var controller;
  // DatabaseReference childRef;
  // if (ref == dbController.light) {
  //   controller = LightController();
  //   childRef = ref.child(child);
  // } else if (ref == dbController.sensor) {
  //   controller = SensorController();
  //   childRef = ref.child(child);
  // } else if (ref == dbController.actuators) {
  //   controller = ActuatorController();
  //   childRef
  // }
}
