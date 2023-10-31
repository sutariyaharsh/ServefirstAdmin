import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/location/components/location_list_view_item.dart';
import 'package:servefirst_admin/view/location/controller/location_controller.dart';
import 'package:servefirst_admin/view/surveys/surveys_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationController());
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      return GetBuilder<LocationController>(
        builder: (controller) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: isPortrait ? 15.h : 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, color: AppTheme.lightGrayTextColor),
                        Text(
                          "Dashboard",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 16.sp : 10.sp, color: AppTheme.lightGrayTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.locationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => SurveysScreen(index: index));
                            },
                            child: LocationListViewItem(location: controller.locationList[index], isPortrait: isPortrait));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
