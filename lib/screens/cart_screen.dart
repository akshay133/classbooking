import 'package:classbooking/controller/db_helper_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: GetBuilder<DbHelperAndCartController>(
        init: DbHelperAndCartController(),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_.count > 0)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.date.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Time",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.time.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Availability",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.available.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Booking",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange),
                                  onPressed: () {},
                                  child: const Text("Cancel"),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    else
                      const Center(
                        child: Text("Your Cart is Empty!"),
                      ),
                    if (_.count > 1)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.date.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Time",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.time.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Availability",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.available.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Booking",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange),
                                  onPressed: () {},
                                  child: const Text("Cancel"),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    else
                      Container(),
                    if (_.count > 2)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.date1.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Time",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.time1.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Availability",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_.available2.toString()),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Booking",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange),
                                  onPressed: () {
                                    _.decrement();
                                    FirebaseFirestore.instance
                                        .collection("class_booking")
                                        .doc("PFFnz4vQ1P7uOnUPJPV8")
                                        .update(
                                      {
                                        "subjects.subject3.time_available.availability3":
                                            _.available2 - 1
                                      },
                                    );
                                  },
                                  child: const Text("Cancel"),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    else
                      Container()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
