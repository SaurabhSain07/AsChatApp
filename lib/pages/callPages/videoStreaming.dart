import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:aschatapp/configur/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LiveVideoStreaming extends StatefulWidget {
  final UserModel target;
  final String isHost;
  const LiveVideoStreaming(
      {super.key, required this.target, required this.isHost});

  @override
  State<LiveVideoStreaming> createState() => _LiveVideoStreamingState();
}

class _LiveVideoStreamingState extends State<LiveVideoStreaming> {
  ProfileController profileController =Get.put(ProfileController());
  ChatController chatController =Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    var liveId=chatController.getRoomId(widget.target.id!);
    return ZegoUIKitPrebuiltLiveStreaming(
    appID: ZegoCloudConfig2.appId, // your AppID,
    appSign: ZegoCloudConfig2.appSing,
    userID: profileController.currentUser.value.id ?? "root",
    userName: profileController.currentUser.value.name ?? "root",
    liveID: liveId,
    config: widget.isHost == profileController.currentUser.value.id
        ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
        : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
  );
  }
}