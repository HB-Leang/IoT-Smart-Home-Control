import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/actuator_controller.dart';
import 'package:smart_home_control/controllers/light_controller.dart';
import 'package:smart_home_control/controllers/sensor_controller.dart';
import 'package:smart_home_control/views/error_screen.dart';
import 'package:smart_home_control/views/home_page.dart';
import 'package:smart_home_control/views/homescreen.dart';

class DatabaseController extends GetxController {
  bool isConected = false;

  final LightController lightController = Get.put(LightController());
  final SensorController sensorController = Get.put(SensorController());
  final ActuatorController actuatorController = Get.put(ActuatorController());
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  late DatabaseReference light = database.child('smart-home/light');
  late DatabaseReference sensor = database.child('smart-home/sensor');
  late DatabaseReference actuators = database.child('smart-home/actuators');
  // var  ledref = database.child('LivingRoom/');

  // final DatabaseReference ledref = FirebaseDatabase.instance.ref("LivingRoom");

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await databaseInit();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (isConected == true) {
        Get.offAll(() => HomePage());
      } else {
        Get.offAll(() => ErrorConnect());
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

    // livingRoom.child('led1').once().then((snap) {
    //   // final data = snap.snapshot.value;
    //   // livingLed.value = data as int? ?? 0;

    //   final data = snap.snapshot;
    //   livingLed.value = data.value as int? ?? 0;

    //   print(livingLed.value);
    // });
    // isConected = true;
    light.onValue.listen((DatabaseEvent event) {
      getLightValue(event);
      // Map<dynamic, dynamic> values =
      //     event.snapshot.value as Map<dynamic, dynamic>;
      // print("light values in listen : $values");
      // final snapshot = event.snapshot;
      // print("event raise");
      // // print(event.toString());
      // // print(snapshot.value);

      // lightController.livingRoom.value =
      //     snapshot.child("livingRoom/state").value as int? ?? 0;

      // // final snap = event.snapshot.value;
      // // livingLed.value = snap as int? ?? 0;
      // if (snapshot.key == 'livingRoom') {
      //   livingLed.value = snapshot.child("state").value as int? ?? 0;
      //   // print('living');
      //   // print(livingLed.value);
      // } else if (snapshot.key == '1stFloor') {
      //   firstFloor.value = snapshot.child("state").value as int? ?? 0;
      // }
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
    // print("light values : $values");

    lightController.garage.value = values['garage'];
    lightController.balcony.value = values['balcony'];
    lightController.bedRoom1.value = values['bedRoom1'];
    lightController.bedRoom2.value = values['bedRoom2'];
    lightController.firstFloor.value = values['firstFloor'];
    lightController.kitchen.value = values['kitchen'];
    lightController.livingRoom.value = values['livingRoom'];
  }

  void getSensorValue(DatabaseEvent snap) {
    Map<dynamic, dynamic> values = snap.snapshot.value as Map<dynamic, dynamic>;
    // print("Sensor value : $values");

    sensorController.temp.value = double.parse(values['dht']['temp']);
    sensorController.hum.value = double.parse(values['dht']['hum']);
  }

  void getActuatorsValue(DatabaseEvent snap) {
    Map<dynamic, dynamic> values = snap.snapshot.value as Map<dynamic, dynamic>;

    actuatorController.doors['balcony']!.value = values['door']['balcony'];
    actuatorController.doors['bedRoom1']!.value = values['door']['bedRoom1'];
    actuatorController.doors['bedRoom2']!.value = values['door']['bedRoom2'];
    actuatorController.doors['frontDoor']!.value = values['door']['frontDoor'];
    actuatorController.doors['garage']!.value = values['door']['garage'];
  }

  void on_off(DatabaseReference dbRef, String childName) async {
    // final child = await dbRef.child(childName).get();
    // final child = await database.child('LivingRoom/led1/').get();
    // if (child.exists) print(child.value);
    final db = dbRef.child(childName);
    final snapshot = await db.get();
    // print("snap value get :${snapshot.child(childName).value}");
    await db.set(snapshot.child(childName).value == 1 ? 0 : 1);
    update();
    // print("led : ${snapshot.child(childName).child('state').value}");
    // final snapshot2 = await db.get();
    // print(" snap : ${snapshot2.child("livingRoom").value}");
    // dbRef.update({childName: snapshot.child(childName).value == 1 ? 0 : 1});
    // dbRef.update({childName: snapshot.child(childName).value == 1 ? 0 : 1});
  }
}




// Future checkFirebase() async {
//   Future.delayed(const Duration(seconds: 2)).then((value) {
//     if(d)
//   });