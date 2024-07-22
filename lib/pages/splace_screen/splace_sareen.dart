import 'package:aschatapp/Controller/splaceController.dart';
import 'package:aschatapp/configur/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplaceScreen extends StatelessWidget {
  const SplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController=Get.put(SplaceController());
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AssetsImage.appIconSVG),
      ),
    );
  }
}
