import 'dart:io';

import 'package:aschatapp/pages/Chats/Widgets/messageType.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiPage extends StatelessWidget {
  const EmojiPage({super.key});

  @override
  Widget build(BuildContext context) {

    return EmojiPicker(
    textEditingController: MessageType.messageController, 
    config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          backgroundColor: Colors.black,
        emojiSizeMax: 28 *
        (Platform.isIOS
            ?  1.20
            :  1.0),
        ),
        
    ),
);
  }
}