import 'package:aschatapp/configur/Colors.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/configur/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeFooterButton extends StatelessWidget {
  const WelcomeFooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
                onSubmit: (){
                  Get.offAllNamed("/authPage");
                },
                sliderButtonIcon: SvgPicture.asset(
                  AssetsImage.plugSVG,
                ),
                text: WelcomePageString.slideToStartNow,
                textStyle: Theme.of(context).textTheme.labelLarge,
                submittedIcon: SvgPicture.asset(AssetsImage.connectSVG),
                innerColor: dOnSecondry,
                outerColor: Theme.of(context).colorScheme.primaryContainer,
              )
            ;
  }
}