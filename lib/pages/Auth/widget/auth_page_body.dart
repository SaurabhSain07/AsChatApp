import 'package:aschatapp/pages/Auth/widget/login_form.dart';
import 'package:aschatapp/pages/Auth/widget/singup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
      // height: 400,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Obx((){
                    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => isLogin.value= true,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.7,
                              child: Column(
                                children: [
                                  Text(
                                    "Login",
                                    style: isLogin.value
                                        ? Theme.of(context).textTheme.bodyLarge
                                        : Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: isLogin.value ? 100 : 0,
                              height: 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).colorScheme.primary),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => isLogin.value=false,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.7,
                              child: Column(
                                children: [
                                  Text(
                                    "Singup",
                                    style:isLogin.value?Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: isLogin.value ? 0 : 100,
                              height: 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).colorScheme.primary),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                
                  })
                ],
              ))
            ],
          ),
          
          Obx(() => isLogin.value ? const LoginForm() : const SingUpForm())
        ],
      ),
    );
  }
}
