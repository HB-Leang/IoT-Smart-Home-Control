import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/controllers/weather_controller.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/models/my_switch.dart';
import 'package:smart_home_control/models/size.dart';
import 'package:smart_home_control/models/weather_model.dart';
import 'package:smart_home_control/widgets/iot_switch.dart';
import 'package:smart_home_control/widgets/mode_set_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController databaseController = Get.put(DatabaseController());
    final WeatherController weatherController = Get.put(WeatherController());
    // final WeatherModel currentWeather = weatherController.listWeather[0];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: MediaQuery.sizeOf(context).height * 0.8,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Group3 Smart Home",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.9,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade400,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: cardBackgroundColor,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon(
                        //   Icons.sunny,
                        //   size: 60,
                        //   color: Colors.orange,
                        // ),

                        Image.network(
                          "https://openweathermap.org/img/wn/${weatherController.weather.value?.weather[0].icon}@2x.png",
                          fit: BoxFit.cover,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) =>
                                  child,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            "${weatherController.weather.value!.weather[0].description.capitalize}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Obx(
                          () => Text(
                            "${databaseController.sensorController.temp.value} \u2103", // \u2103 is Celsius icon
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const Text(
                          "Temperature",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Obx(
                          () => Text(
                            "${databaseController.sensorController.hum.value} %",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const Text(
                          "Humidity",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: cardBackgroundColor,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          databaseController.on_off(
                              databaseController.actuators, "gate");
                        },
                        child: const ModeSetButton(
                          icon: Icons.night_shelter,
                          label: "Sleep",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const ModeSetButton(
                          icon: Icons.wb_sunny_outlined,
                          label: "Day",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const ModeSetButton(
                          icon: Icons.nights_stay_outlined,
                          label: "Night",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.blue.shade200,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Gate",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IoTSwitch(
                                mySwitch: MySwitch(
                                    reference: databaseController.actuators,
                                    childName: "gate",
                                    initValue: databaseController
                                        .actuatorController.gate),
                                activeChild: "OPEN",
                                inactiveChild: "CLOSE",
                                toggleSize: 30,
                                width: 105,
                                height: 40,
                                borderRadius: 30.0)
                          ],
                        ),
                        const Expanded(
                          child: Icon(
                            Icons.door_back_door_outlined,
                            size: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
