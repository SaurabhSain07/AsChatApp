import 'package:aschatapp/Controller/EmojiPickerController.dart';
import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/Controller/imagePickerController.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/widgets/imagePickerBottemSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MessageType extends StatelessWidget {
  final UserModel userModel;
  static final messageController = TextEditingController();
  const MessageType({super.key, required this.userModel,});

  @override
  Widget build(BuildContext context) {
    ChatController chatController=Get.put(ChatController());
    ImagePickerController imagePickerController=Get.put(ImagePickerController());
    RxString message="".obs;
    EmojiPickerController emojiPickerController =Get.put(EmojiPickerController());
    
    return Container(
          margin:const EdgeInsets.all(10),
          padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(100)),
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  emojiPickerController.isEmoji.value =
                      !emojiPickerController.isEmoji.value;
                      FocusScope.of(context).unfocus();
                      message.value.isNotEmpty;
                },
                child: Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.grey[200],
                )
              ),
              
              SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  onTap: () {
                   emojiPickerController.isEmoji.value =false;
                  },
                  onChanged: (value){
                    message.value=value;
                    messageController.value;
                  },
                  controller: messageController,
                  decoration:const InputDecoration(
                    hintText: "Type message...",
                    filled: false),
                )
                ),
              const SizedBox(width: 10,),
              Obx(() => chatController.selectedImagePath.value==""
              ?InkWell(
                onTap: () {
                  imagePickerBottemSheet(
                            context,
                            chatController.selectedImagePath,
                            imagePickerController);
                },
                child: SvgPicture.asset(AssetsImage.gallerySVG))
                :InkWell(
                  onTap: (){
                    chatController.selectedImagePath.value="";
                  },
                  child:const SizedBox(),
                ),),
              const SizedBox(width: 10,),
              Obx(() => message.value != "" ||
                    chatController.selectedImagePath.value != "" ||
                    messageController.value != ""
              ? InkWell(
                onTap: () {
                  if (messageController.text.isNotEmpty ||
                          chatController.selectedImagePath.value.isNotEmpty) {
                        chatController.sendMessage(
                            userModel.id!, messageController.text, userModel);
                        messageController.clear();
                        message.value = "";
                      }
                },
                child: chatController.isLoading.value 
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
