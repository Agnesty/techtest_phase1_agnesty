import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techtest_phase1_agnesty/models/data_model.dart';

class ApiService extends GetxController {
  RxList<DataModel> data = <DataModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

//Mengambil Data dari JSON
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

//Filter data agar yang muncul hanya isActive = 1
  List<DataModel> filterActiveProducts() {
    return data.where((product) => product.isActive == "1").toList();
  }
  
//Permission untuk izin di storage dan lokasi  
  Future<void> requestPermissions() async {
    final storageStatus = await Permission.storage.request();
    final locationStatus = await Permission.location.request();

    if (storageStatus.isGranted) {
      print('Izin akses penyimpanan lokal diberikan');
    } else {
      print('Izin akses penyimpanan lokal ditolak');
    }

    if (locationStatus.isGranted) {
      print('Izin akses GPS diberikan');
    } else {
      print('Izin akses GPS ditolak');
    }
  }
}
