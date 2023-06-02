import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/dataModel_ctr.dart';
import '../widgets/item_card.dart';
import '../widgets/promosi_card.dart';

class DataScreen extends StatelessWidget {
  static String routeName = "/splashscreen";
  DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DataModelCtr _dataModelController = Get.find();
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
                onPressed: () {},
                icon: Icon(
                  size: 35,
                  Icons.add,
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
      body: Obx(() => Column(
            children: [
              PromosiCard(),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ItemCard(
                        icon: Icons.laptop,
                        bnyk: "7",
                        name: "Laptop",
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _dataModelController.allData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange.shade600,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: SizedBox(
                                        width: 200,
                                        child: CachedNetworkImage(
                                          imageUrl: _dataModelController
                                              .allData[index].gambar!,
                                          fit: BoxFit.contain,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  'assets/images/placeholder.png'),
                                          errorWidget: (context, url, error) =>
                                              const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Gambar tidak bisa dimuat, check koneksi Anda',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10,
                                                ),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      width: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _dataModelController
                                                .allData[index].title!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            "Asus",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "Rp ${NumberFormat.decimalPattern('id-ID').format(int.parse(_dataModelController.allData[index].price!))}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
