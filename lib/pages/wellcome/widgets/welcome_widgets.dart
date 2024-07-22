import 'package:aschatapp/configur/Colors.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:aschatapp/configur/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsImage.appIconSVG,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              AppString.appName,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: dOnSecondry),
            )
          ],
        );
  }
}