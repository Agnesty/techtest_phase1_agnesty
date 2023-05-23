import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/models/data_model.dart';

class ApiService extends GetxController {
  RxList<DataModel> data = <DataModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final response =
          await rootBundle.loadString('assets/json_files/response.json');
      final decodedResponse = json.decode(response);
      var list = decodedResponse['data'] as List<dynamic>;
      data.value = list.map((e) => DataModel.fromJson(e)).toList();
    } catch (e) {
      print('Error: $e');
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  List<DataModel> filterActiveProducts(List<DataModel> products) {
    return products.where((product) => product.isActive == "1").toList();
  }
}
