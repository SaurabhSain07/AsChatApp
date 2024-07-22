import 'package:aschatapp/Controller/authController.dart';
import 'package:aschatapp/Model/userModel.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/pages/UserProfile/Widgets/login_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/profileController.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel userModel;
  const UserProfilePage({super.key, required this.userModel});
  @override
  Widget build(BuildContext context) {
  
  AuthController authController=Get.put(AuthController());
  ProfileController profileController=Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed("/updateProfile");
          }, icon: Icon(Icons.edit))
        ],
        ),
      body: Column(
        children: [
          LoginUserInfo(
            profileImage: userModel.profileImage ?? AssetsImage.defaultProfileImage,
            userName: userModel.name?? "User",
            userEmail: userModel.email?? "",
          ),
          Spacer(),
          
          ElevatedButton(onPressed: (){
            authController.logoutUser();
          }, child: Text("Logout"))
        ],
      ),
    );
  }
}
