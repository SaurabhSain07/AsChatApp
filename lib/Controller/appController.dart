import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppController extends GetxController {
  RxString oldVersion="".obs;
  RxString currentVersion="".obs;
  RxString newAppUrl="".obs;

   void onInit()async{
    super.onInit();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion.value=packageInfo.version;
    checkLatestVersion();
   }
  
  Future<void> checkLatestVersion()async{
     const repositoryOwner = 'SaurabhSain07';
     const repositoryName = 'ASChat';

     final response = await http.get(Uri.parse(
        'https://api.github.com/repos/$repositoryOwner/$repositoryName/releases/latest'));

      if(response.statusCode==200){
        final Map<String, dynamic> data = json.decode(response.body);

        final tagName = data['tag_Name'];
        final assets = data['assets'] as List<dynamic>;
        oldVersion.value=tagName;
        for (final asset in assets) {
          final assetName = asset['name'];
          final assetDownloadUrl = asset['browser_download_url'];
          newAppUrl.value=assetDownloadUrl;
        }
       if (currentVersion.value != oldVersion.value) {
        checkUpdate(); 
       } else {
      Get.rawSnackbar(
      duration:const Duration(minutes: 5),
      message: "Already update",
      icon:const Icon(Icons.update_sharp),
      barBlur: 20,
      snackStyle: SnackStyle.FLOATING,
      leftBarIndicatorColor: Colors.blue,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("Update now"),
      ),
    );
       }
      }else{
        print("failed to fatch GitHub release status Code ${response.statusCode}");
      }
  }

  void checkUpdate() {
    Get.rawSnackbar(
      duration:const Duration(seconds: 30),
      message: "New Update Avalable",
      icon:const Icon(Icons.update_sharp),
      barBlur: 20,
      snackStyle: SnackStyle.FLOATING,
      leftBarIndicatorColor: Colors.blue,
      mainButton: TextButton(
        onPressed: () {

          launchUrl(Uri.parse(newAppUrl.value),
              mode: LaunchMode.externalApplication);
          Get.back();
        },
        child: const Text("Update now"),
      ),
    );
  }

}