import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/data_model.dart';
import '../services/loading_status.dart';
import '../services/references.dart';

class DataModelCtr extends GetxController {
  final allData = <DataModel>[].obs;
  final loadingStatus = LoadingStatus.loading.obs;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  Future<void> loadData() async {
    loadingStatus.value = LoadingStatus.loading;

    try {
      final QuerySnapshot<Map<String, dynamic>> materiQuery =
          await dataPaperFR
              .doc('techtest')
              .collection('dataProduk')
              .get();

      final data = materiQuery.docs
          .map((materi) => DataModel.fromSnapshot(materi))
          .toList();

       // Filter produk dengan is_active == "0"
      final filteredData = data.where((product) => product.isActive != "0").toList();

      allData.assignAll(filteredData);
      // allData.assignAll(data);

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
}
