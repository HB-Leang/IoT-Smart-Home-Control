import 'package:get/get.dart';

class SensorController extends GetxController {
  RxDouble temp = 0.0.obs;
  RxDouble hum = 0.0.obs;
  RxInt flame = 0.obs;
  RxInt gas = 0.obs;
  RxInt rain = 0.obs;
  RxInt car1 = 0.obs;
  RxInt car2 = 0.obs;
}
