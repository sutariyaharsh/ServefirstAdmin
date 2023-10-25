import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/responsive_widget.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/view/thank_you/controller/thank_you_controller.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThankYouController());
    return GetBuilder<ThankYouController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        body: ResponsiveWidget(
          mobile: Image.asset(
            bgThankYouPortrait, // Replace with your image path
            fit: BoxFit.cover, // This makes the image cover the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
          tab: Image.asset(
            bgThankYouLandscape, // Replace with your image path
            fit: BoxFit.cover, // This makes the image cover the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
