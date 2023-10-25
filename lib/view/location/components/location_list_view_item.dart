import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class LocationListViewItem extends StatelessWidget {
  const LocationListViewItem({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.location_on),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name ?? "",
                  maxLines: 2,
                  style: TextStyle(color: AppTheme.lightTextBlackColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  location.address1 ?? "",
                  maxLines: 1,
                  style: TextStyle(color: AppTheme.lightTextColor, fontWeight: FontWeight.w400, fontSize: 12.sp),
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
