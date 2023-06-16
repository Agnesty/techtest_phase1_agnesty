import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/data_model.dart';
import '../services/loading_status.dart';
import '../services/references.dart';

class ProductCtr extends GetxController {
  final allData = <DataModel>[].obs;
  final loadingStatus = LoadingStatus.loading.obs;

  List<DataModel> _items = [];
  List<DataModel> get items {
    return [..._items];
  }

  DataModel findById(String id) {
    return allData.firstWhere((produk) => produk.id == id);
  }

  @override
  void onReady() {
    super.onReady();
    ProductData();
  }

  //Fecth semua data produk di firestore
  Future<void> ProductData() async {
    loadingStatus.value = LoadingStatus.loading;
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    print('product: $userId');

    try {
      final QuerySnapshot<Map<String, dynamic>> materiQuery = await dataPaperFR
          .doc('techtest')
          .collection('dataProduk')
          .where('id', isEqualTo: userId)
          .get();

      final data = materiQuery.docs
          .map((dataMo) => DataModel.fromSnapshot(dataMo))
          .toList();

      allData.assignAll(data);

      if (allData.isNotEmpty) {
        loadingStatus.value = LoadingStatus.completed;
      } else {
        loadingStatus.value = LoadingStatus.error;
      }
    } catch (e) {
      print(e.toString());
      loadingStatus.value = LoadingStatus.error;
    }
  }

  //Add new produk di firestore
  Future<void> addProduct(String title, String price, String gambar) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User belum logins
      return;
    }
   
    try {
      DataModel newProduct = DataModel(
        id: user.uid,
        title: title,
        price: price,
        gambar: gambar,
      );

      await dataPaperFR.doc('techtest').collection('dataProduk').doc().set(newProduct.add());
       
    } catch (error) {
      print(error);
      throw error;
    }
  }

  //Update produk di firestore
  Future<void> updateProduct(String id, String title, String price, String gambar) async {
    final productRef =
        dataPaperFR.doc('techtest').collection('dataProduk').doc(id);

    try {
      await productRef.update({
        'title': title,
        'gambar': gambar,
        'price': price,
      });
    } catch (error) {
      debugPrint('Something went wrong(Update): $error');
      throw error;
    }
  }

  //Delete produk di firestore
  void deleteData(String id) {
    CustomFullScreenDialog.showDialog();
    dataPaperFR.doc('techtest').collection('dataProduk').doc(id).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Product Deleted",
          message: "Product deleted successfully",
          backgroundColor: Colors.purple.shade400);
    }).catchError((error) {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong",
          backgroundColor: Colors.red);
    });
  }
}

class CustomFullScreenDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}

class CustomSnackBar {
  static void showSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white, ),
        ),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(16));
  }
}
