import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {

  void checkUpdate() {
    Get.rawSnackbar(
      title: "New Update Avalable",
      message: "Voice call & Video Call is work properly",
      mainButton: TextButton(
        onPressed: () {},
        child: const Text("Update now"),
      ),
    );
  }
}