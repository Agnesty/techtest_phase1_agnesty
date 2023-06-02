import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/controllers/dataModel_ctr.dart';
import 'package:techtest_phase1_agnesty/controllers/responModel_ctr.dart';

class InitialBinding implements Bindings {
  @override 
  void dependencies() {
     Get.lazyPut(() => ResponModelCtr());
     Get.lazyPut(() => DataModelCtr());
  }
}

