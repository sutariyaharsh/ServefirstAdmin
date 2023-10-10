import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/location/components/location_list_view_item.dart';
import 'package:servefirst_admin/view/surveys/components/survey_list_view_item.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: AppTheme.lightGrayTextColor),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppTheme.lightGrayTextColor),
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
                  itemCount: locationController.locationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.surveys, arguments: index)!.then((value) {});
                        },
                        child: LocationListViewItem(
                            location: locationController.locationList[index]));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
