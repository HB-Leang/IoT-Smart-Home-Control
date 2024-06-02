import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_control/models/color.dart';
import 'package:smart_home_control/views/about_us_screen.dart';
import 'package:smart_home_control/views/homescreen.dart';
import 'package:smart_home_control/views/outdoor_screen.dart';
import 'package:smart_home_control/views/rooms_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  RxInt selected = 0.obs;
  final List pages = [
    HomeScreen(),
    RoomScreen(),
    OutdoorScreen(),
    AboutUsScreen(),
  ];

  // final List<BottomBarItem> items = [
  //   BottomBarItem(
  //     icon: const Icon(Icons.home_sharp),
  //     title: const Text('Home Control'),
  //     backgroundColor: Colors.red,
  //     // selectedIcon: const Icon(Icons.read_more),
  //   ),
  //   BottomBarItem(
  //     icon: const Icon(Icons.room_preferences),
  //     title: const Text('Room Control'),
  //     backgroundColor: Colors.orange,
  //   ),
  // ];

  final List<TabItem> items = const [
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.meeting_room,
      title: 'Rooms',
    ),
    TabItem(
      icon: Icons.gite,
      title: 'Outdoor',
    ),
    TabItem(
      icon: Icons.person,
      title: 'About Us',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[selected.value],
        bottomNavigationBar: BottomBarInspiredInside(
          items: items,
          backgroundColor: Colors.white,
          color: mainColor,
          colorSelected: Colors.white,
          indexSelected: selected.value,
          // paddingVertical: 24,
          onTap: (int index) => {selected.value = index},
          chipStyle: const ChipStyle(convexBridge: true, background: mainColor),
          itemStyle: ItemStyle.circle,
          animated: true,
        ),
      ),
    );
  }
}
