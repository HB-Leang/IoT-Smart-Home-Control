import 'package:get/get.dart';
import 'package:smart_home_control/models/weather_model.dart';
import 'package:smart_home_control/services/api_services.dart';

class WeatherController extends GetxController {
  final Rx<WeatherModel?> weather = Rx<WeatherModel?>(null);
  RxBool loading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  Future getData() async {
    try {
      var product = await APIService().fetchAPIData();
      if (product != null) {
        weather.value = product;
      }
      loading(true);
    } finally {
      loading(false);
    }
  }
}
