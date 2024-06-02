import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home_control/controllers/database_controller.dart';
import 'package:smart_home_control/firebase_options.dart';
import 'package:smart_home_control/views/home_page.dart';
import 'package:smart_home_control/views/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController databaseController = Get.put(DatabaseController());
    return GetMaterialApp(
      title: 'IoT Smart Home Controller',
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      useImmersiveMode: true,
      // duration: const Duration(milliseconds: 2000),
      // nextScreen: const HomePage(),
      backgroundColor: Colors.white,
      // asyncNavigationCallback: () async => ,
      splashScreenBody: Center(
        child: Lottie.asset(
          "assets/animations/openning.json",
          width: MediaQuery.sizeOf(context).width * 0.5,
          height: MediaQuery.sizeOf(context).height * 0.5,
          repeat: true,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// class LoadingScreen extends StatelessWidget {
//   const LoadingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//           child: CupertinoActivityIndicator(
//         radius: 18,
//       )),
//     );
//   }
// }
