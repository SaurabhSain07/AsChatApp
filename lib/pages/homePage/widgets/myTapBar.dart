import 'package:flutter/material.dart';


myTabBar(TabController tabController,BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
      indicatorWeight: 4,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      controller: tabController,
      tabs: [
      Text("Chats"),
      Text("Groups"),
      Text("Calls"),
    ]),
  );
}
