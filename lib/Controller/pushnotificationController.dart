import 'dart:developer';

import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/Model/ChatModel.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';


class PushNotificationController extends GetxController{
  late UserModel userModel;
  final FirebaseStorage storage=FirebaseStorage.instance;
  final FirebaseFirestore db=FirebaseFirestore.instance;
  final FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseMessaging FMessaging = FirebaseMessaging.instance;
  ChatController chatController= Get.put(ChatController());

  Future<void> getFirebaseMessagingToken()async{
    await FMessaging.requestPermission();

    await FMessaging.getToken().then((token){
      if (token != null) {
        userModel.pushNotification = token;
        log("Push Notification: $token");
      }
    });
  }
  
  Future<void> updateNotification(String tergetUserId)async{   
    await db.collection("users").doc(auth.currentUser!.uid).update({
      'PushNotification': userModel.pushNotification,
    });
  }
}