import 'package:aschatapp/Controller/GroupController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/GroupChat/GroupChatPage.dart';
import 'package:aschatapp/pages/homePage/widgets/chatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController=Get.put(GroupController());
    return Obx(() => ListView(
      children: groupController.groupList
          .map((group) => InkWell(
          onTap: (){
            Get.to(GroupChatPage(groupModel: group));
          },
          child: ChatTile(
              name: group.name!,
              imageUrl: group.profileUrl == ""
                        ? AssetsImage.defaultProfileImage
                        : group.profileUrl!,
              lastChat: "Last Chat",
              lastTime: "just Now"),
          )
        ).toList(),
    ));
  }
}