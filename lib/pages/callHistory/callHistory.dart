import 'package:aschatapp/Controller/chatController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/homePage/widgets/chatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController =Get.put(ChatController());
    return StreamBuilder(
      stream: chatController.getCalls(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context,index){
              // DateTime timestamp =
                //     DateTime.parse(snapshot.data![index].timestamp!);
                // String formattedTime = DateFormat('hh:mm a').format(timestamp);
             return ChatTile(
                      imageUrl: snapshot.data![index].callerPic ??
                          AssetsImage.defaultProfileImage,
                      name: snapshot.data![index].callerName ?? "Usar",
                      lastChat: snapshot.data![index].status ?? "...",
                      lastTime: "");
                });
        }else{
         return Center(
              child: Container(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(),
              ),
            );
        }
      });
  }
}