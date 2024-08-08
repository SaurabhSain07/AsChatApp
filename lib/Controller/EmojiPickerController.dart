import 'dart:io';

import 'package:aschatapp/pages/Chats/Widgets/messageType.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:get/get.dart';

class EmojiPickerController extends GetxController{
  RxBool isEmoji = false.obs;

  setEmojiValue(bool value){
    isEmoji.value=value;
  }
  
  Future<void> getEmoji()async{
    await EmojiPicker(
    textEditingController: MessageType.messageController, 
    config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
        emojiSizeMax: 28 *
        (Platform.isIOS
            ?  1.20
            :  1.0),
        ),
        
    ),
);
  }
}