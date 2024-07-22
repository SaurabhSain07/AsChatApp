import 'package:aschatapp/Controller/authController.dart';
import 'package:aschatapp/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingUpForm extends StatelessWidget {
  const SingUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController=TextEditingController();
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
         TextField(
          controller: nameController,
          decoration:const InputDecoration(
              hintText: "Full Name", prefixIcon: Icon(Icons.person)),
        ),
        const SizedBox(
          height: 40,
        ),
         TextField(
          controller: emailController,
          decoration:const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.alternate_email_outlined)),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: passwordController,
          decoration:const InputDecoration(
              hintText: "password", prefixIcon: Icon(Icons.password_outlined)),
        ),
       const SizedBox(
          height: 50,
        ),
        Obx(() => authController.isLoading.value
            ? CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    ontap: () {
                      // Get.offAllNamed("/homePage");
                      authController.createUser(emailController.text, passwordController.text, nameController.text);
                    },
                    btnName: "SINGUP",
                    icon: Icons.lock_open_sharp,
                  ),
                ],
              ))
      ],
    );
  }
}
