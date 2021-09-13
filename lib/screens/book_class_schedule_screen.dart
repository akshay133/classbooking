import 'dart:async';

import 'package:classbooking/controller/db_helper_controller.dart';
import 'package:classbooking/screens/cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookClassScheduleScreen extends StatefulWidget {
  const BookClassScheduleScreen({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<BookClassScheduleScreen> createState() =>
      _BookClassScheduleScreenState();
}

class _BookClassScheduleScreenState extends State<BookClassScheduleScreen> {
  final dbController = Get.put(DbHelperAndCartController());

  late Timer _timer;
  int _start = 60;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start--;
              }
            }));
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Schedule'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(const CartScreen());
                },
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
              Positioned(
                left: 0,
                top: 8,
                child: GetBuilder<DbHelperAndCartController>(
                    init: DbHelperAndCartController(),
                    builder: (_) {
                      return Text("${_.count}");
                    }),
              )
            ],
          )
        ],
      ),
      body: _start == 0
          ? const Center(child: Text('Free Trial Finished!'))
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: dbController.getSubjects(),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.size,
                          itemBuilder: (ctx, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[0];
                            var time1 = ds['subjects']["subject${widget.index}"]
                                ["time_available"]["time1"];
                            var time2 = ds['subjects']["subject${widget.index}"]
                                ["time_available"]["time2"];
                            var time3 = ds['subjects']["subject${widget.index}"]
                                ["time_available"]["time3"];
                            var availability1 = ds['subjects']
                                    ["subject${widget.index}"]["time_available"]
                                ["availability1"];
                            var availability2 = ds['subjects']
                                    ["subject${widget.index}"]["time_available"]
                                ["availability2"];
                            var availability3 = ds['subjects']
                                    ["subject${widget.index}"]["time_available"]
                                ["availability3"];
                            var totalSeats =
                                availability1 + availability2 + availability3;
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        offset: const Offset(2, 2))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text('Time left: $_start seconds'),
                                    const Text(
                                      'claim your Free Trial Class',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Free Seats Left $totalSeats',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    "Date",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(ds["subjects"][
                                                          "subject${widget.index}"]
                                                      ["date"]),
                                                  const Divider(),
                                                  Text(ds["subjects"][
                                                          "subject${widget.index}"]
                                                      ["date"]),
                                                  const Divider(),
                                                  Text(ds["subjects"][
                                                          "subject${widget.index}"]
                                                      ["date"]),
                                                  const Divider(),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Time',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(time1),
                                                  const Divider(),
                                                  Text(time2),
                                                  const Divider(),
                                                  Text(time3),
                                                  const Divider(),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Availability',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text("$availability1"),
                                                  const Divider(),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text("$availability2"),
                                                  const Divider(),
                                                  const SizedBox(
                                                    height: 28,
                                                  ),
                                                  Text("$availability3"),
                                                  const Divider(),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  'Booking',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                if (availability1 != 0)
                                                  GetBuilder<
                                                          DbHelperAndCartController>(
                                                      init:
                                                          DbHelperAndCartController(),
                                                      builder: (_) {
                                                        return ElevatedButton(
                                                          onPressed: () {
                                                            if (_.count <= 2) {
                                                              _.increment();
                                                              _.addCartItem(
                                                                time1,
                                                                ds["subjects"][
                                                                        "subject${widget.index}"]
                                                                    ["date"],
                                                                availability1,
                                                              );
                                                              Get.snackbar(
                                                                  "Added", "",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "class_booking")
                                                                  .doc(
                                                                      "PFFnz4vQ1P7uOnUPJPV8")
                                                                  .update(
                                                                {
                                                                  "subjects.subject${widget.index}.time_available.availability1":
                                                                      availability1 -
                                                                          1
                                                                },
                                                              );
                                                            } else {
                                                              Get.snackbar(
                                                                  "Oops!",
                                                                  "You can only book 3 seats in 1 week",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Book Now'),
                                                        );
                                                      })
                                                else
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    onPressed: () {
                                                      Get.snackbar("Sorry",
                                                          "Seats is full choose another one",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM);
                                                    },
                                                    child: const Text('Full'),
                                                  ),
                                                if (availability2 != 0)
                                                  GetBuilder<
                                                          DbHelperAndCartController>(
                                                      init:
                                                          DbHelperAndCartController(),
                                                      builder: (_) {
                                                        return ElevatedButton(
                                                          onPressed: () {
                                                            if (_.count <= 2) {
                                                              _.increment();
                                                              _.addCartItem2(
                                                                time1,
                                                                ds["subjects"][
                                                                        "subject${widget.index}"]
                                                                    ["date"],
                                                                availability1,
                                                              );
                                                              Get.snackbar(
                                                                  "Added", "",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "class_booking")
                                                                  .doc(
                                                                      "PFFnz4vQ1P7uOnUPJPV8")
                                                                  .update(
                                                                {
                                                                  "subjects.subject${widget.index}.time_available.availability2":
                                                                      availability2 -
                                                                          1
                                                                },
                                                              );
                                                            } else {
                                                              Get.snackbar(
                                                                  "Oops!",
                                                                  "You can only book 3 seats in 1 week",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Book Now'),
                                                        );
                                                      })
                                                else
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    onPressed: () {
                                                      Get.snackbar("Sorry",
                                                          "Seats is full choose another one",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM);
                                                    },
                                                    child: const Text('Full'),
                                                  ),
                                                if (availability3 != 0)
                                                  GetBuilder<
                                                          DbHelperAndCartController>(
                                                      init:
                                                          DbHelperAndCartController(),
                                                      builder: (_) {
                                                        return ElevatedButton(
                                                          onPressed: () {
                                                            if (_.count <= 2) {
                                                              _.increment();
                                                              _.addCartItem3(
                                                                time2,
                                                                ds["subjects"][
                                                                        "subject${widget.index}"]
                                                                    ["date"],
                                                                availability2,
                                                              );
                                                              Get.snackbar(
                                                                  "Added", "",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "class_booking")
                                                                  .doc(
                                                                      "PFFnz4vQ1P7uOnUPJPV8")
                                                                  .update(
                                                                {
                                                                  "subjects.subject${widget.index}.time_available.availability3":
                                                                      availability3 -
                                                                          1
                                                                },
                                                              );
                                                            } else {
                                                              Get.snackbar(
                                                                  "Oops!",
                                                                  "You can only book 3 seats in 1 week",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Book Now'),
                                                        );
                                                      })
                                                else
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.red),
                                                    onPressed: () {
                                                      Get.snackbar("Sorry",
                                                          "Seats is full choose another one",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM);
                                                    },
                                                    child: const Text('Full'),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
    );
  }
}
