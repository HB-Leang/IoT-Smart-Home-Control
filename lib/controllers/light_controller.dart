import 'package:firebase_database/firebase_database.dart';
import 'package:get/state_manager.dart';

class LightController extends GetxController {
  RxInt firstFloor = 0.obs;
  RxInt balcony = 0.obs;
  RxInt bedRoom1 = 0.obs;
  RxInt bedRoom2 = 0.obs;
  RxInt garage = 0.obs;
  RxInt kitchen = 0.obs;
  RxInt livingRoom = 0.obs;
  RxInt garageFront = 0.obs;
  DatabaseReference lightPath =
      FirebaseDatabase.instance.ref().child('smart-home/light');

  late final Map<String, RxInt> _lightMap;

  LightController() {
    _lightMap = {
      'firstFloor': firstFloor,
      'balcony': balcony,
      'bedRoom1': bedRoom1,
      'bedRoom2': bedRoom2,
      'garage': garage,
      'kitchen': kitchen,
      'livingRoom': livingRoom,
      'garageFront': garageFront,
    };
  }

  RxInt getLight(String name) {
    return _lightMap[name] ?? RxInt(0);
  }

  void led_on_off(DatabaseReference dbRef, String childName) async {
    // final child = await dbRef.child(childName).get();
    // final child = await database.child('LivingRoom/led1/').get();
    // if (child.exists) print(child.value);
    final db = dbRef.child(childName);
    final snapshot = await db.get();
    await db.set(snapshot.child(childName).value == 1 ? 0 : 1);
  }
}
