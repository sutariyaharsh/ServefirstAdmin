import 'package:flutter/material.dart';
import 'package:servefirst_admin/component/svg_icon.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppTheme.lightPrimaryColor,
      body: Center(
        child: SvgIcon(assetImage: icTextLogoWhite),
      ),
    );
  }
}
