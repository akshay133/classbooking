import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DbHelperAndCartController extends GetxController {
  var count = 0.obs;
  var time = "".obs;
  var date = "".obs;
  var available = 0.obs;
  var time1 = "".obs;
  var date1 = "".obs;
  var available1 = 0.obs;
  var time2 = "".obs;
  var date2 = "".obs;
  var available2 = 0.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void increment() {
    count++;
    update();
  }

  void decrement() {
    count--;
    update();
  }

  void addCartItem(String dbTime, String dbDate, int dbAvailable) {
    time = dbTime.obs;
    date = dbDate.obs;
    available = dbAvailable.obs;
    update();
  }

  void addCartItem2(
    String dbTime,
    String dbDate,
    int dbAvailable,
  ) {
    time1 = dbTime.obs;
    date1 = dbDate.obs;
    available1 = dbAvailable.obs;
    update();
  }

  void addCartItem3(String dbTime, String dbDate, int dbAvailable) {
    time2 = dbTime.obs;
    date2 = dbDate.obs;
    available2 = dbAvailable.obs;
    update();
  }

  Stream<QuerySnapshot> getSubjects() {
    return _db.collection("class_booking").snapshots();
  }
}
