import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/dataUploader/response_data_uploader.dart';

import '../services/loading_status.dart';


class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);

  ResponseDataUploader controller = Get.put(ResponseDataUploader());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(()=> Text(controller.loadingStatus.value == LoadingStatus.completed? "Uploading Completed" : "uploading..."))
      ),
    );
  }
}