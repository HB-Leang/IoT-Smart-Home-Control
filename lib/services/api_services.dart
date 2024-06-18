import 'package:http/http.dart' as http;
import 'package:smart_home_control/api/weather_api.dart';
import 'package:smart_home_control/models/weather_model.dart';

class APIService {
  Future fetchAPIData() async {
    try {
      var response = await http.get(Uri.parse(weatherAPI));
      if (response.statusCode == 200) {
        return weatherModelFromJson(response.body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
