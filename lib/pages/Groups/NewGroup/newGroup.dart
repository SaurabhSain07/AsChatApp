import 'package:aschatapp/Controller/GroupController.dart';
import 'package:aschatapp/Controller/contactController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/Groups/NewGroup/groupTitle.dart';
import 'package:aschatapp/pages/Groups/NewGroup/selectMembersList.dart';
import 'package:aschatapp/pages/homePage/widgets/chatTile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController=Get.put(ContactController());
    GroupController groupController=Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(title:const Text("New Group"),),
      floatingActionButton: Obx(() => FloatingActionButton(
        onPressed: () {
          if (groupController.groupMembers.isEmpty) {   
            Get.snackbar("Error", "Please Select atlast one member");
          } else {
            Get.to(GroupTitle());
          }
        },
        backgroundColor: groupController.groupMembers.isEmpty
         ? Colors.grey
         :Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.arrow_forward,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),),
      body: Column(
        children: [
          SelectdMembersList(),
         const SizedBox(height: 10,),
          Row(
            children: [
              Text(
                "Contasts on VSChatApp",
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
         const SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder(stream:contactController.getContact() ,
             builder: (context, snapshot){
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
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: (){
                                      groupController.selectMembers(snapshot.data![index]);
                                    },
                                    child: ChatTile(
                                      imageUrl: snapshot.data![index].profileImage?? AssetsImage.defaultProfileImage,
                                      name: snapshot.data![index].name!,
                                      lastChat: snapshot.data![index].about ?? "",
                                      lastTime: ""),
                                  );
                                },
                              );
                            }
             }),
          ),
        ],
      ),
    );
  }
}