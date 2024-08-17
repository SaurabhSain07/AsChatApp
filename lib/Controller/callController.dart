import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/Controller/cloudRecordingController.dart';
import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/Model/AudioCall.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:aschatapp/pages/callPages/audioCallPage.dart';
import 'package:aschatapp/pages/callPages/videoCallPage.dart';
import 'package:aschatapp/pages/callPages/videoStreaming.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v4();
  
  ChatController chatController = Get.put(ChatController());
  ProfileController profileController=Get.put(ProfileController());
  
  @override
  void onInit() {
    super.onInit();
    getCallsNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        if (callData.type == "audio") {
          audioCallNotification(callData);
        } else if (callData.type == "video") {
          videoCallNotification(callData);
        }
      }
    });
  }

  Future<void> audioCallNotification(CallModel callData) async {
    Get.snackbar(
      barBlur: 0,
      backgroundColor: Colors.grey,
      isDismissible: false,
      icon:const Icon(Icons.call),
      onTap: (snack) {
        Get.to(
          AudioCallPage(
            target: UserModel(
                id: callData.callerUid,
                name: callData.callerName,
                email: callData.callerEmail,
                profileImage: callData.callerPic),
          ),
        );
        Get.back();
      },
      duration:const Duration(days: 1),
      callData.callerName!,
      "Incoming Audio Call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text("Call end"),
      ),
    );
  }

  Future<void> callAction(
      UserModel reciver, UserModel caller, String type) async {
    String id = uuid;
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverName: reciver.name,
      receiverPic: reciver.profileImage,
      receiverUid: reciver.id,
      receiverEmail: reciver.email,
      status: "dialing",
      type: type,
      // time: nowTime,
      timestamp: DateTime.now().toString(),
    );

    try {
      await db
          .collection("notification")
          .doc(reciver.id)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .add(newCall.toJson());
      await db
          .collection("users")
          .doc(reciver.id)
          .collection("calls")
          .add(newCall.toJson());
      Future.delayed(Duration(seconds: 20), () {
        endCall(newCall);
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<CallModel>> getCallsNotification() {
    return FirebaseFirestore.instance
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CallModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  void videoCallNotification(CallModel callData) {
    Get.snackbar(
      barBlur: 0,
      backgroundColor: Colors.grey,
      isDismissible: false,
      icon:const Icon(Icons.video_call),
      onTap: (snack) {
        Get.to(
          VideoCallPage(
            target: UserModel(
                id: callData.callerUid,
                name: callData.callerName,
                email: callData.callerEmail,
                profileImage: callData.callerPic,
                
                ),
          ),
        );
        Get.back();
      },
      duration:const Duration(days: 1),
      callData.callerName!,
      "Incoming Video Call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text("Call end"),
      ),
    );
  }
}
