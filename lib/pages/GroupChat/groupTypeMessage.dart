import 'package:aschatapp/Controller/GroupController.dart';
import 'package:aschatapp/Controller/imagePickerController.dart';
import 'package:aschatapp/Model/GroupModel.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/widgets/imagePickerBottemSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class GroupMessageType extends StatelessWidget {
  final GroupModel groupModel;
  const GroupMessageType({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController=TextEditingController();
    ImagePickerController imagePickerController=Get.put(ImagePickerController());
    GroupController groupController= Get.put(GroupController());
    RxString message="".obs;
    return Container(
          margin:const EdgeInsets.all(10),
          padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(100)),
          child: Row(
            children: [
              InkWell(
                onTap: (){},
                child: const Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.white38,
                )),
             const SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  onChanged: (value){
                    message.value=value;
                  },
                  controller: messageController,
                  decoration:const InputDecoration(
                    hintText: "Type message...",
                    filled: false),
                )
                ),
              const SizedBox(width: 10,),
              Obx(() => groupController.selectedImagePath.value==""
              ?InkWell(
                onTap: () {
                  imagePickerBottemSheet(
                            context,
                            groupController.selectedImagePath,
                            imagePickerController);
                },
                child: SvgPicture.asset(AssetsImage.gallerySVG))
                :InkWell(
                  onTap: (){
                    groupController.selectedImagePath.value="";
                  },
                  child:const SizedBox(),
                ),),
              const SizedBox(width: 10,),
              Obx(() => message.value != "" ||
                    groupController.selectedImagePath.value != ""
              ? InkWell(
                onTap: () {
                  groupController.sendGroupMessage(
                  messageController.text, 
                  groupModel.id!,
                  "",  
                  );
                  messageController.clear();
                  message.value="";
                },
                child: groupController.isLoading.value 
                ?const CircularProgressIndicator()
                :SvgPicture.asset(AssetsImage.sendSVG)
              )  
              : InkWell(
                onTap: (){},
                child: SvgPicture.asset(AssetsImage.micSVG))
              
             )
            ],
          )
         );
  }

  
}