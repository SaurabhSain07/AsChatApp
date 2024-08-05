import 'package:aschatapp/Model/ChatModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushNotificationController extends GetxController{
  FirebaseMessaging FMessaging = FirebaseMessaging.instance;

  Future<void> getFirebaseMessagingToken(ChatModel chatModel)async{
    await FMessaging.requestPermission();

    await FMessaging.getToken().then((token){
      if (token != null) {
        chatModel.pushNotification = token;
      }
    });
  }
}