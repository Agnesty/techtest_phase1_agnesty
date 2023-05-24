import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techtest_phase1_agnesty/models/data_model.dart';

import '../controllers/menu_ctr.dart';

class HomeScreen extends StatelessWidget {
  final ApiService apiService = Get.put(ApiService());

// Memuat data saat pertama kali dibangun
  HomeScreen() {
    apiService.requestPermissions();
    apiService.fetchData(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Home", style: TextStyle(color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.blue[800],
                size: 30,
              ),
              onPressed: () {}),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (apiService.isLoading.value) {
          return const CircularProgressIndicator();
        } else if (apiService.hasError.value) {
          return const Center(
            child: Text("Terjadi kesalahan saat memuat data"),
          );
        } else {
          List<DataModel> activeProducts =
              apiService.filterActiveProducts();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                itemCount: activeProducts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      height: 400,
                      width: 400,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: activeProducts[index].gambar!,
                              fit: BoxFit.contain,
                              placeholder: (context, url) =>
                                  Image.asset('assets/images/placeholder.png'),
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
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              width: 400,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Harga : ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    "Rp ${NumberFormat.decimalPattern('id-ID').format(int.parse(activeProducts[index].price!))}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
      }),
    );
  }
}
