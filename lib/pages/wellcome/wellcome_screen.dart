import 'package:aschatapp/pages/wellcome/widgets/welcome_body.dart';
import 'package:aschatapp/pages/wellcome/widgets/welcome_widgets.dart';
import 'package:aschatapp/pages/wellcome/widgets/welcomefooter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WelcomeWidget(),
              WelcomeBody(),
              WelcomeFooterButton()
            ],
          ),
        ),
      ),
    );
  }
}
