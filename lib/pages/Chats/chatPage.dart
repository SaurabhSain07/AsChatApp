import 'dart:io';

import 'package:aschatapp/Controller/EmojiPickerController.dart';
import 'package:aschatapp/Controller/callController.dart';
import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/Chats/Widgets/ChatBubble.dart';
import 'package:aschatapp/pages/Chats/Widgets/Emoji.dart';
import 'package:aschatapp/pages/Chats/Widgets/messageType.dart';
import 'package:aschatapp/pages/UserProfile/Profile.dart';
import 'package:aschatapp/pages/callPages/audioCallPage.dart';
import 'package:aschatapp/pages/callPages/videoCallPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController=Get.put(ChatController());
    ProfileController profileController=Get.put(ProfileController());
    CallController callController=Get.put(CallController());
    // TextEditingController messageController=TextEditingController();
    EmojiPickerController emojiPickerController =Get.put(EmojiPickerController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        emojiPickerController.isEmoji.value=false;
      } ,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
              Get.to(UserProfilePage(
                userModel: userModel,
              ));
            },
            child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: userModel.profileImage ?? AssetsImage.defaultProfileImage,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>const Icon(Icons.error),
                  ),
                ))),
          ),
          title: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.to(UserProfilePage(
                userModel: userModel,
              ));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(userModel.name ?? "User",
                     style: Theme.of(context).textTheme.bodyLarge,),
      
                     StreamBuilder(
                        stream: chatController.getStatus(userModel.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState==ConnectionState.waiting) {
                            return const Text(".....");
                          }
                          return Text(
                            snapshot.data!.status ?? "",
                            style: TextStyle(
                                fontSize: 11,
                                color: snapshot.data!.status == "Online"
                                    ? Colors.green
                                    : Colors.grey),
                          );
                        }) 
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                callController.callAction(
                    userModel, profileController.currentUser.value, "audio");
                    Get.to(AudioCallPage(target: userModel));
              },
              icon: const Icon(Icons.call_sharp),
            ),
            IconButton(
              onPressed: () {
                callController.callAction(
                    userModel, profileController.currentUser.value, "video");
                    Get.to(VideoCallPage(target: userModel));
              },
              icon: const Icon(Icons.videocam_outlined),
            )
          ],
        ),
          
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                    stream: chatController.getMessage(userModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      }
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text("No Messages"),
                        );
                      } else {
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime timestamp = DateTime.parse(
                                snapshot.data![index].timestamp!);
                            String formattedTime =
                                DateFormat('hh:mm a').format(timestamp);
                            return GestureDetector(
                              onLongPress: () {
                                showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                        await chatController.deleteMessage(userModel.id!);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white60
                      ),
                      child: const Text(
                        "Delete for everyone",
                        style: TextStyle(color: Colors.black, 
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                        Get.back();
                      },
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white60
                      ),
                      child: const Text("Delete for Me",
                      style: TextStyle(color: Colors.black, 
                        fontWeight: FontWeight.bold),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white60
                      ),
                      child: const Text("Cancel",
                      style: TextStyle(color: Colors.black, 
                        fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              );
            });
                              },
                              child: ChatBubble(
                                message: snapshot.data![index].message!,
                                imageUrl: snapshot.data![index].imageUrl ?? "",
                                isComming: snapshot.data![index].receiverId ==
                                    profileController.currentUser.value.id,
                                status: "read",
                                time: formattedTime,
                              ),
                            );
                          },
                        );
                      }
                    },
                   ),
                  Obx(() => (chatController.selectedImagePath.value != "")
                        ? Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: 500,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(File(chatController
                                              .selectedImagePath.value)),
                                          fit: BoxFit.fill),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                        Positioned(
                          right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          chatController.selectedImagePath.value="";
                                        },
                                        icon:const Icon(Icons.close)))
                      ],
                    ),
                   ):Container())
                  ],
                ),
              ),
              MessageType(userModel: userModel,),
              Obx(()=>emojiPickerController.isEmoji.value ==true
              ? EmojiPage()
              : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
