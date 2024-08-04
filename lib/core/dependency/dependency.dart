
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_scan/Scann/Controller/scanner_controller.dart';
class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================User section==================
   Get.lazyPut(() => BleController(), fenix: true);

  }
}
