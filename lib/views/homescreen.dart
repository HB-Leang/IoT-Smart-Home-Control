import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/controllers/weather_controller.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/models/my_switch.dart';
import 'package:smart_home_control/models/size.dart';
import 'package:smart_home_control/widgets/iot_switch.dart';
import 'package:smart_home_control/widgets/mode_set_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController databaseController = Get.put(DatabaseController());
    final WeatherController weatherController = Get.put(WeatherController());
    RxBool isButtonClicked = false.obs;
    // final WeatherModel currentWeather = weatherController.listWeather[0];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9 + 20,
            height: MediaQuery.sizeOf(context).height * 1,
            // color: Colors.red,
            child: RefreshIndicator(
              onRefresh: () async {
                return await weatherController.getData();
              },
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  // just for scrollable
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.8,
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
                                  Image.network(
                                    "https://openweathermap.org/img/wn/${weatherController.weather.value?.weather[0].icon}@2x.png",
                                    fit: BoxFit.cover,
                                    frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) =>
                                        child,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 170,
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
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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
                            child: Obx(() => AbsorbPointer(
                                  absorbing: isButtonClicked.value,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await databaseController.mode.set(3);
                                          isButtonClicked(true);
                                          showModeChangedSnackBar(
                                            "Mode Changed",
                                            "Sleep mode activated.\nPerforming needed tasks.",
                                            Icons.night_shelter,
                                          );
                                          Future.delayed(
                                                  const Duration(seconds: 4))
                                              .whenComplete(
                                                  () => isButtonClicked(false));
                                        },
                                        child: const ModeSetButton(
                                          icon: Icons.night_shelter,
                                          label: "Sleep",
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await databaseController.mode.set(1);
                                          isButtonClicked(true);
                                          showModeChangedSnackBar(
                                            "Mode Changed",
                                            "Day mode activated.\nPerforming needed tasks.",
                                            Icons.wb_sunny_outlined,
                                          );
                                          Future.delayed(
                                                  const Duration(seconds: 4))
                                              .whenComplete(
                                                  () => isButtonClicked(false));
                                        },
                                        child: const ModeSetButton(
                                          icon: Icons.wb_sunny_outlined,
                                          label: "Day",
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await databaseController.mode.set(2);
                                          isButtonClicked(true);
                                          showModeChangedSnackBar(
                                            "Mode Changed",
                                            "Night mode activated.\nPerforming needed tasks.",
                                            Icons.nights_stay_outlined,
                                          );
                                          Future.delayed(
                                                  const Duration(seconds: 4))
                                              .whenComplete(
                                                  () => isButtonClicked(false));
                                        },
                                        child: const ModeSetButton(
                                          icon: Icons.nights_stay_outlined,
                                          label: "Night",
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.65,
                            height: MediaQuery.sizeOf(context).height * 0.2,
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Front Door",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            softWrap: true,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        child: IoTSwitch(
                                            mySwitch: MySwitch(
                                                reference: databaseController
                                                    .actuators,
                                                childName: "door/frontDoor",
                                                initValue: databaseController
                                                    .actuatorController
                                                    .getDoor("frontDoor")),
                                            activeChild: "OPEN",
                                            inactiveChild: "CLOSE",
                                            toggleSize: switchSize['door']![
                                                'toggleSize'],
                                            width:
                                                switchSize['door']!['width']!,
                                            height:
                                                switchSize['door']!['height']!,
                                            borderRadius: 30.0),
                                      )
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Obx(
                                    () => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: databaseController
                                                  .actuatorController
                                                  .getDoor("frontDoor")
                                                  .value ==
                                              1
                                          ? Image.asset(
                                              "assets/icons/door-open.png",
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/icons/door-close.png",
                                              fit: BoxFit.cover,
                                              // width: 20,
                                            ),
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
                  // just for scrollable
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showModeChangedSnackBar(String title, String message, IconData icon) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: mainColor,
        icon: Icon(
          icon,
          size: 36,
        ),
        title: title,
        message: message,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(10.0),
        borderRadius: 15.0,
        forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        reverseAnimationCurve: Curves.decelerate,
      ),
    );
  }
}
