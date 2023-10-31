import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class LocationListViewItem extends StatelessWidget {
  const LocationListViewItem({super.key, required this.location, required this.isPortrait});

  final Location location;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isPortrait ? 25.w : 12.5.w, vertical: isPortrait ? 30.h : 60.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.location_on),
          SizedBox(width: isPortrait ? 15.w : 7.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name ?? "",
                  maxLines: 2,
                  style: TextStyle(color: AppTheme.lightTextBlackColor, fontWeight: FontWeight.w500, fontSize: isPortrait ? 16.sp : 10.sp),
                ),
                SizedBox(height: isPortrait ? 5.h : 10.h),
                Text(
                  location.address1 ?? "",
                  maxLines: 1,
                  style: TextStyle(color: AppTheme.lightTextColor, fontWeight: FontWeight.w400, fontSize: isPortrait ? 12.sp : 8.sp),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
