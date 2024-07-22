import 'dart:io';

import 'package:aschatapp/Controller/GroupController.dart';
import 'package:aschatapp/Controller/profileController.dart';
import 'package:aschatapp/Model/GroupModel.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/Chats/Widgets/ChatBubble.dart';
import 'package:aschatapp/pages/GroupChat/groupTypeMessage.dart';
import 'package:aschatapp/pages/GroupInfo/groupInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupChatPage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChatPage({super.key, required this.groupModel,});

  @override
  Widget build(BuildContext context) {
    GroupController groupController=Get.put(GroupController());
    ProfileController profileController=Get.put(ProfileController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: groupModel.profileUrl == ""
                          ? AssetsImage.defaultProfileImage
                          : groupModel.profileUrl!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>const Icon(Icons.error),
                    ),
                  )),
            ),
          ),
          title: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.to(GroupInfo(groupModel: groupModel,));
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(groupModel.name ?? "Group Name",
                     style: Theme.of(context).textTheme.bodyLarge,),
                     Text("Online", 
                     style: Theme.of(context).textTheme.labelMedium,
                      selectionColor: Colors.white,),  
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call_sharp),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.videocam_outlined))
          ],
        ),
    
        body: Padding(
          padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                    stream: groupController.getGroupMessages(groupModel.id!),
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
                            return ChatBubble(
                              message: snapshot.data![index].message!,
                              imageUrl: snapshot.data![index].imageUrl ?? "",
                              isComming: snapshot.data![index].senderId !=
                                  profileController.currentUser.value.id,
                              status: "read",
                              time: formattedTime,
                            );
                          },
                        );
                      }
                    },
                   ),
                  Obx(() => (groupController.selectedImagePath.value!="")? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        Container(
                          margin:const EdgeInsets.only(bottom: 10),
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: FileImage(
                              File(groupController.selectedImagePath.value)
                             ),
                             fit: BoxFit.fill
                            ),
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(15)),
                        ),
                        Positioned(
                          right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          groupController.selectedImagePath.value="";
                                        },
                                        icon:const Icon(Icons.close)))
                      ],
                    ),
                   ):Container())
                  ],
                ),
              ),
              GroupMessageType(groupModel: groupModel,)
            ],
          ),
        ),
      ),
    );
  }
}
