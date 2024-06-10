import 'package:get/get.dart';

class ActuatorController extends GetxController {
  RxInt curtain = 0.obs;
  RxInt gate = 0.obs;
  RxInt window = 0.obs;

  Map<String, RxInt> doors = {
    'balcony': 0.obs,
    'bedRoom1': 0.obs,
    'bedRoom2': 0.obs,
    'frontDoor': 0.obs,
    'garage': 0.obs,
  };

  Map<String, RxInt> fans = {
    'bedRoom1': 0.obs,
    'bedRoom2': 0.obs,
    'kitchen': 0.obs,
  };

  RxInt getDoor(String name) {
    return doors[name] ?? RxInt(0);
  }

  RxInt getFan(String name) {
    return fans[name] ?? RxInt(0);
  }
}
