import 'package:aschatapp/Controller/GroupController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectdMembersList extends StatelessWidget {
  const SelectdMembersList({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController=Get.put(GroupController());
    return Obx(
      () => Row(
        children: groupController.groupMembers
            .map((e) => Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:
                              e.profileImage ?? AssetsImage.defaultProfileImage,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          groupController.groupMembers.remove(e);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}