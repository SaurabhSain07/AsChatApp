import 'package:aschatapp/Controller/callController.dart';
import 'package:aschatapp/configur/Theme.dart';
import 'package:aschatapp/firebase_options.dart';
import 'package:aschatapp/pages/page_path.dart';
import 'package:aschatapp/pages/splace_screen/splace_sareen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      title: 'VsChatapp',
      theme: lightTheme,
      getPages: pagePath,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: SplaceScreen(),
      // home: ProfilePage(),
    );
  }
}

