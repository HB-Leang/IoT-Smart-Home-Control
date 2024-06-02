import 'package:get/get.dart';

class ActuatorController extends GetxController {
  RxInt curtain = 0.obs;

  Map<String, RxInt> doors = {
    'balcony': 0.obs,
    'bedRoom1': 0.obs,
    'bedRoom2': 0.obs,
    'frontDoor': 0.obs,
    'garage': 0.obs,
  };

  RxInt getDoor(String name) {
    return doors[name] ?? RxInt(0);
  }
}
