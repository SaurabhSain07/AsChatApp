import 'package:aschatapp/Controller/contactController.dart';
import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/Chats/chatPage.dart';
import 'package:aschatapp/pages/homePage/widgets/chatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController =Get.put(ContactController());
    ProfileController profileController =Get.put(ProfileController());
    return RefreshIndicator(child: Obx(() => ListView(
      children: contactController.chatRoomList.map((e) => InkWell(
          onTap: (){
           Get.to(
            ChatPage(
             userModel: (e.receiver!.id ==
                     profileController.currentUser.value.id
                 ? e.sender
                 : e.receiver)!,));
          },
          child: ChatTile(
            imageUrl: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender!.profileImage
                              : e.receiver!.profileImage) ??
                          AssetsImage.defaultProfileImage,
            name:(e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender!.name
                              : e.receiver!.name)!,
            lastChat:e.lastMessage?? "Last message",
            lastTime:e.lastMessageTimestamp?? "Last Time",
          ),
        ),).toList()
     )
    ), onRefresh: (){
      return contactController.getChatRoomList();
    });
    
  }
}
