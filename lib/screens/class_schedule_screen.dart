import 'package:classbooking/controller/db_helper_controller.dart';
import 'package:classbooking/screens/book_class_schedule_screen.dart';
import 'package:classbooking/screens/cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassScheduleScreen extends StatelessWidget {
  ClassScheduleScreen({Key? key}) : super(key: key);
  final dbController = Get.put(DbHelperAndCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Class Schedule"),
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: dbController.getSubjects(),
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot ds = snapshot.data!.docs[0];
                    var subjectsTime = ds['subjects']["subject${index + 1}"]
                        ["time_available"]["time1"];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Name',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.to(
                                              BookClassScheduleScreen(
                                                index: index + 1,
                                              ),
                                            );
                                          },
                                          child: Text(ds['subjects']
                                              ["subject${index + 1}"]["name"]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Week days',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24),
                                        child: Text(ds['subjects']
                                            ["subject${index + 1}"]["week"]),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Time for May 2021',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(subjectsTime
                                              .toString()
                                              .substring(0, 8)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
