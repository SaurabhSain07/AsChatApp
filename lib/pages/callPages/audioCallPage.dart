import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/Controller/cloudRecordingController.dart';
import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:aschatapp/configur/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatelessWidget {
  final UserModel target;
  const AudioCallPage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    var callId = chatController.getRoomId(target.id!);
    
    final userId = profileController.currentUser.value.id ?? "root";
    final roomId = chatController.getRoomId(target.id!);
  
    cloudRecording(userId, roomId);
  
    return ZegoUIKitPrebuiltCall(
        appID: ZegoCloudConfig.appId,
        appSign: ZegoCloudConfig.appSing,
        userID: profileController.currentUser.value.id ?? "root",
        userName: profileController.currentUser.value.name ?? "root",
        callID: callId,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
      );  
      
 }

 void cloudRecording(String userId, String roomId)async{
  final zegoRecording = ZegoCloudRecording();
  
  // Replace with actual UserID and RoomID
  
  await zegoRecording.startCloudRecording(userId, roomId);
 }
}