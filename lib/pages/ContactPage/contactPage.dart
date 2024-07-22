import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/Controller/contactController.dart';
import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/Chats/chatPage.dart';
import 'package:aschatapp/pages/ContactPage/Widgets/contatSearch.dart';
import 'package:aschatapp/pages/ContactPage/Widgets/newContactTile.dart';
import 'package:aschatapp/pages/Groups/NewGroup/newGroup.dart';
import 'package:aschatapp/pages/homePage/widgets/chatTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController=Get.put(ContactController());
    ProfileController profileController=Get.put(ProfileController());
    ChatController chatController=Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Select contact"),
        actions: [
          Obx(() => IconButton(onPressed: () {
            isSearchEnable.value= !isSearchEnable.value;
          },
           icon:isSearchEnable.value
           ?Icon(Icons.close) 
           :Icon(Icons.search)
           ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
         child: ListView(
         children: [
         const SizedBox(height: 10,),
         Obx(() => isSearchEnable.value? ContactSearch(): SizedBox()),
         const SizedBox(height: 10,),
          NewContactTile(
              icon: Icons.person_add,
              btnName: 'New contact',
              ontap: () {},
            ),
          const SizedBox(height: 10,),  
          NewContactTile(
              icon: Icons.person_add,
              btnName: 'New Group',
              ontap: () {
                Get.to(NewGroup());
              },
            ),
         const SizedBox(height: 10),
          const Row(
              children: [
                Text("Contacts on Sampark"),
              ],
            ),
          SizedBox(height: 10,),
          Obx(() => Column(
            children: contactController.userList.map(
              (e) => InkWell(
                onTap: () {
                  Get.to(ChatPage(userModel: e));
                },
                child: ChatTile(
                  imageUrl: e.profileImage?? AssetsImage.defaultProfileImage,
                  name: e.name ?? "User",
                  lastChat: e.about?? "Hay there", 
                  lastTime: e.email! ==
                                        profileController
                                            .currentUser.value.email
                                    ? "You"
                                    : ""
                  ),
              )).toList()
            ,
          ))
         ],
        ),
      ),
    );
  }
}