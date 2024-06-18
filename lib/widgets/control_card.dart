import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:smart_home_control/models/my_switch.dart';
import 'package:smart_home_control/widgets/iot_switch.dart';

class ControlCard extends StatelessWidget {
  const ControlCard({
    super.key,
    required this.controlName,
    required this.mySwitch,
    this.activeChild = "ON",
    this.inactiveChild = "OFF",
    this.toggleSize,
    this.width = 80.0,
    this.height = 40.0,
    this.borderRadius = 30.0,
    this.activeImage = "assets/icons/light-bulb-on.png",
    this.inactiveImage = "assets/icons/light-bulb-off.png",
    this.isFan = false,
  });
  final String controlName;
  final MySwitch mySwitch;
  final String activeChild;
  final String inactiveChild;
  final double? toggleSize;
  final double width;
  final double height;
  final double borderRadius;
  final String activeImage;
  final String inactiveImage;
  final bool isFan;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.17,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.blueGrey,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controlName,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => Container(
                    width: 80,
                    height: 80,
                    // color: Colors.black,
                    alignment: Alignment.center,
                    child: isFan
                        ? Lottie.asset(
                            "assets/animations/fan-spin.json",
                            fit: BoxFit.cover,
                            animate:
                                mySwitch.initValue.value == 1 ? true : false,
                            repeat: true,
                          )
                        : mySwitch.initValue.value == 1
                            ? Image.asset(
                                activeImage,
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              )
                            : Image.asset(
                                inactiveImage,
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              )),
              ),
            ],
          ),
          IoTSwitch(
            mySwitch: mySwitch,
            activeChild: activeChild,
            inactiveChild: inactiveChild,
            toggleSize: toggleSize,
            width: width,
            height: height,
            borderRadius: borderRadius,
          ),
        ],
      ),
    );
  }
}
