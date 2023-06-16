import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/controllers/auth_ctr.dart';
import 'package:techtest_phase1_agnesty/screens/detail_product_screen.dart';
import 'package:techtest_phase1_agnesty/screens/login_screen.dart';

import '../models/data_model.dart';
import '../services/references.dart';
import '../widgets/item_card.dart';
import '../widgets/item_product.dart';
import '../widgets/promosi_card.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/homescreen";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue[100]),
            child: const Icon(
              Icons.flutter_dash,
              color: Colors.deepPurple,
              size: 30,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 10),
            child: Container(
              width: 50,
              height: 50,
              child: IconButton(
                onPressed: () {
                  authController.logout();
                  Get.offAll(LoginScreen());
                },
                icon: const Icon(
                  size: 30,
                  Icons.logout_outlined,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
        ],
        title: const Text(
          "LeptopIn",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              PromosiCard(),
              const SizedBox(
                height: 15,
              ),
              ItemCard(),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 310,
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Product",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "See All",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: dataPaperFR
                            .doc('techtest')
                            .collection('dataProduk')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return const Center(child: Text('Error'));
                          }
                          final toList = snapshot.data!.docs
                              .map((e) => DataModel.fromSnapshot(e))
                              .toList();
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: toList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var dataToList = toList[index];
                                return ItemProduct(
                                  dataModel: dataToList,
                                  ontap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DetailProductScreen(
                                                dataModel: dataToList),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
