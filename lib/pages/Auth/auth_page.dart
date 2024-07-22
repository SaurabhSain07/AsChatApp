import 'package:aschatapp/pages/Auth/widget/auth_page_body.dart';
import 'package:aschatapp/pages/wellcome/widgets/welcome_widgets.dart';
import 'package:flutter/material.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              WelcomeWidget(),
              SizedBox(
                height: 40,
              ),
              AuthPageBody(),
              
            ]),
          ),
        ),
      ),
    );
  }
}
