import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/actuator_controller.dart';
import 'package:smart_home_control/controllers/light_controller.dart';
import 'package:smart_home_control/controllers/notification_controller.dart';
import 'package:smart_home_control/controllers/sensor_controller.dart';
import 'package:smart_home_control/views/error_screen.dart';
import 'package:smart_home_control/views/home_page.dart';

class DatabaseController extends GetxController {
  bool isConected = false;

  final LightController lightController = Get.put(LightController());
  final SensorController sensorController = Get.put(SensorController());
  final ActuatorController actuatorController = Get.put(ActuatorController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  late DatabaseReference mode = database.child("smart-home/mode");
  late DatabaseReference light = database.child('smart-home/light');
  late DatabaseReference sensor = database.child('smart-home/sensor');
  late DatabaseReference actuators = database.child('smart-home/actuators');

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await databaseInit();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (isConected == true) {
        Get.offAll(() => HomePage());
      } else {
        Get.offAll(() => const ErrorConnect());
      }
    });
  }

  Future databaseInit() async {
    var lightSnap = await light.once();
    if (lightSnap.snapshot.value == null) {
      return false;
    }
    getLightValue(lightSnap);

    var sensorSnap = await sensor.once();
    if (sensorSnap.snapshot.value == null) {
      return false;
    }
    getSensorValue(sensorSnap);

    var actuatorsnap = await actuators.once();
    if (actuatorsnap.snapshot.value == null) {
      return false;
    }
    getActuatorsValue(actuatorsnap);
    light.onValue.listen((DatabaseEvent event) {
      getLightValue(event);
      update();
    });

    sensor.onValue.listen((event) {
      getSensorValue(event);
    });

    actuators.onValue.listen((event) {
      getActuatorsValue(event);
    });

    isConected = true;
  }

  void getLightValue(DatabaseEvent snap) {
    Map<dynamic, dynamic> values = snap.snapshot.value as Map<dynamic, dynamic>;

    lightController.garage.value = values['garage'];
    lightController.balcony.value = values['balcony'];
    lightController.bedRoom1.value = values['bedRoom1'];
    lightController.bedRoom2.value = values['bedRoom2'];
    lightController.firstFloor.value = values['firstFloor'];
    lightController.kitchen.value = values['kitchen'];
    lightController.livingRoom.value = values['livingRoom'];
    lightController.garageFront.value = values['garageFront'];
    lightController.frontDoor.value = values['frontDoor'];
  }

  void getSensorValue(DatabaseEvent snap) {
    Map<dynamic, dynamic> values = snap.snapshot.value as Map<dynamic, dynamic>;
    if (double.tryParse(values['dht']['temp'].toString()) != null) {
      sensorController.temp.value =
          double.parse(values['dht']['temp'].toString());
    }

    if (double.tryParse(values['dht']['hum'].toString()) != null) {
      sensorController.hum.value =
          double.parse(values['dht']['hum'].toString());
    }
    sensorController.flame.value = values['flame'];
    if (values['flame'] == 1) {
      notificationController.flameNotification();
    }
    sensorController.gas.value = values['gas'];
    if (values['gas'] == 1) {
      notificationController.gasNotification();
    }
    sensorController.rain.value = values['rain'];
    if (values['rain'] == 1) {
      notificationController.rainNotification();
    }
    sensorController.car1.value = values['car1'];
    sensorController.car2.value = values['car2'];
  }

  void getActuatorsValue(DatabaseEvent snap) {
    Map<dynamic, dynamic> values = snap.snapshot.value as Map<dynamic, dynamic>;

    actuatorController.curtain.value = values['curtain'];
    actuatorController.window.value = values['window'];

    actuatorController.getFan('kitchen').value = values['fan']['kitchen'];
    actuatorController.getFan('bedRoom1').value = values['fan']['bedRoom1'];
    actuatorController.getFan('bedRoom2').value = values['fan']['bedRoom2'];

    actuatorController.doors['balcony']!.value = values['door']['balcony'];
    actuatorController.doors['bedRoom1']!.value = values['door']['bedRoom1'];
    actuatorController.doors['bedRoom2']!.value = values['door']['bedRoom2'];
    actuatorController.doors['frontDoor']!.value = values['door']['frontDoor'];
    actuatorController.doors['garage']!.value = values['door']['garage'];
    if (values['door']['garage'] == -1) {
      notificationController.garageDeniedNotification();
      final db = actuators.child("door/garage");
      db.set(0);
    }
  }

  Future<void> on_off(DatabaseReference dbRef, String childName) async {
    final db = dbRef.child(childName);
    final snapshot = await db.get();
    await db.set(snapshot.child(childName).value == 1 ? 0 : 1);
    update();
  }
}
