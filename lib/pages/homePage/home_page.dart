import 'package:aschatapp/Controller/contactController.dart';
import 'package:aschatapp/Controller/statusController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/configur/string.dart';
import 'package:aschatapp/pages/Groups/GroupPage.dart';
import 'package:aschatapp/pages/homePage/widgets/chatList.dart';
import 'package:aschatapp/pages/homePage/widgets/myTapBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../Profile/profilePage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ContactController contactController =Get.put(ContactController());
    StatusController statusController=Get.put(StatusController());
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AssetsImage.appIconSVG,
          ),
        ),
        title: Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(onPressed: () {
           contactController.getChatRoomList();
          }, icon:const Icon(Icons.search)),
          IconButton(onPressed: () {
            Get.to(ProfilePage());
          }, 
          icon:const Icon(Icons.more_vert)),
        ],
        bottom: myTabBar(tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Get.toNamed("/contactPage");
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: tabController,
          children: [
            ChatList(),
            GroupPage(),
            Text("Calls Page"),
          ]
          ),
      ),
    );
  }
}
