import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/views/bedroom1_screen.dart';
import 'package:smart_home_control/views/bedroom2_screen.dart';
import 'package:smart_home_control/views/firstfloor_screen.dart';
import 'package:smart_home_control/views/garage_screen.dart';
import 'package:smart_home_control/views/kitchen_screen.dart';
import 'package:smart_home_control/views/living_room_page.dart';

class RoomScreen extends StatelessWidget {
  RoomScreen({super.key});
  final tabList = [
    Tab(
      icon: Image.asset(
        "assets/icons/living-room-icon.png",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      text: "Living Room",
    ),
    Tab(
      icon: Image.asset(
        "assets/icons/kitchen-icon.png",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      text: "Kitchen",
    ),
    Tab(
      icon: Image.asset(
        "assets/icons/first_floor-icon.png",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      text: "First Floor",
    ),
    Tab(
      icon: Image.asset(
        "assets/icons/bedroom-icon.png",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      text: "Bedroom 1",
    ),
    Tab(
      icon: Image.asset(
        "assets/icons/bedroom-icon.png",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      text: "Bedroom 2",
    ),
    Tab(
      icon: Image.asset(
        "assets/icons/garage-icon.png",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      text: "Garage",
    ),
  ];
  final pageList = [];
  final DatabaseController databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: DefaultTabController(
            length: tabList.length,
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  height: 110,
                  elevation: 3,
                  splashColor: Colors.blueGrey,
                  buttonMargin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  unselectedBackgroundColor: Colors.white,
                  backgroundColor: mainColor,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  unselectedLabelStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: tabList,
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      LivingRoom(),
                      KitchenScreen(),
                      FirstFloorScreen(),
                      BedRoom1Screen(),
                      BedRoom2Screen(),
                      GarageScreen(),
                    ],
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
