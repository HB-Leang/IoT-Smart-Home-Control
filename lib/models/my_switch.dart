import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class MySwitch {
  final String childName;
  final DatabaseReference reference;
  final RxInt initValue;

  MySwitch({
    required this.reference,
    required this.childName,
    required this.initValue,
  });
}
