import 'package:aschatapp/configur/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class ChatBubble extends StatelessWidget {
  final String message;
  final String imageUrl;
  final bool isComming;
  final String status;
  final String time;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.imageUrl,
      required this.isComming,
      required this.status,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: isComming? CrossAxisAlignment.start: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(minWidth: 100, maxWidth: Get.width / 1.3),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:const Radius.circular(10),
                  topRight:const Radius.circular(10),
                  bottomLeft: isComming? const Radius.circular(0): const Radius.circular(10),
                  bottomRight:isComming? const Radius.circular(10): const Radius.circular(0),
                ),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: imageUrl == "" 
            ? Text(message)
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                               const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                               const Icon(Icons.error),
                          )
                  ), 
                  message =="" ?Container():SizedBox(height: 5,), 
                  message =="" ?Container():Text(message) 
              ],
            ),
          ),
         const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: isComming? MainAxisAlignment.start: MainAxisAlignment.end,
            children: [
              isComming 
              ? Text(time , style: Theme.of(context).textTheme.labelMedium,) 
              : Row(
                children: [
                  Text(time, style: Theme.of(context).textTheme.labelMedium,),
                  SizedBox(width: 10,),
                  SvgPicture.asset(AssetsImage.chatStatusSVG, width: 20,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
