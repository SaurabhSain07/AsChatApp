import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/Model/GroupModel.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/GroupInfo/groupMemberInfo.dart';
import 'package:aschatapp/pages/homePage/widgets/chatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
  ProfileController profileController=Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon:const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        children: [
          GroupMembersInfo(
            groupId: groupModel.id!,
              profileImage: groupModel.profileUrl == ""
                  ? AssetsImage.defaultProfileImage
                  : groupModel.profileUrl!,
              userName: groupModel.name!,
              userEmail: groupModel.description ?? "No description Available"),

             const SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: Text(
              "Members",
              style: Theme.of(context).textTheme.labelMedium,
            ),
             ),
             const SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: Obx(() => Column(
                children: groupModel.members!
                  .map((member) => ChatTile(
                      imageUrl:
                          member.profileImage ?? AssetsImage.defaultProfileImage,
                      name: member.name ?? profileController.currentUser.value.name!,
                      lastChat: member.email!,
                      lastTime: member.role == "admin" ? "Admin" : "User"))
                  .toList(),
               ),)
             )
        ],
      ),
    );
  }
}
