import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/data_model.dart';
import '../services/loading_status.dart';
import '../services/references.dart';

class ResponseDataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;
    final fi = FirebaseFirestore.instance;

    //read asset folder
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    //seperate response json files (check with print the path)
    final papersInAsset = manifestMap.keys
        .where((path) =>
            path.startsWith('assets/json_files') && path.contains('.json'))
        .toList();
    

    List<ResponseModel> dataResponPapers = [];

    for (var paper in papersInAsset) {
      //read content of papers(json files)
      String stringPaperContent = await rootBundle.loadString(paper);
      // print(stringPaperContent);

      //add data to model
      dataResponPapers
          .add(ResponseModel.fromJson(json.decode(stringPaperContent)));
    }
    // print('apakah ada datanya: ${dataPapers[0].message}');

    //upload data to firebase
    var batch = fi.batch();

    for (var paper in dataResponPapers) {
      batch.set(dataPaperFR.doc(paper.id), {
        "status": paper.status,
        "message": paper.message,
        "data": paper.dataModel == null ? 0 : paper.dataModel!.length
      });

      for (var data in paper.dataModel!) {
        final dataPath = dataFR(paperId: paper.id!, dataId: data.id!);
        batch.set(dataPath, {
          "id": data.id,
          "title": data.title,
          "gambar": data.gambar,
          // "is_active": data.isActive,
          // "create_time": data.createTime,
          // "update_time": data.updateTime,
          "price": data.price,
        });
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
