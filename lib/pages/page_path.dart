import 'package:aschatapp/pages/Auth/auth_page.dart';
import 'package:aschatapp/pages/ContactPage/contactPage.dart';
import 'package:aschatapp/pages/Profile/profilePage.dart';
import 'package:aschatapp/pages/homePage/home_page.dart';
import 'package:get/get.dart';

var pagePath = [
  GetPage(
    name: "/authPage",
     page: () =>const AuthPage(),
      transition: Transition.rightToLeft,
     ),

  GetPage(
    name: "/homePage",
     page: () => HomePage(),
      transition: Transition.rightToLeft,
     ),    
  
  GetPage(
    name: "/profilePage",
     page: () => ProfilePage(),
      transition: Transition.rightToLeft,
     ),

  GetPage(
    name: "/contactPage",
     page: () =>const ContactPage(),
      transition: Transition.rightToLeft,
     ),   
  
  // GetPage(
  //   name: "/updateProfile",
  //    page: () => const UserUpdateProfile(),
  //     transition: Transition.rightToLeft,
  //    )
];
