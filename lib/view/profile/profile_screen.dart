import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: AppTheme.lightPrimaryColor,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: AppTheme.lightGrayColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
                top: statusBarHeight + 30.h,
                bottom: 25.h),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 60.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Column(
                    children: [
                      SizedBox(height: 80.h),
                      Obx(
                        () => Text(
                          profileController.loginUser.value?.name ?? "",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Obx(
                        () => Text(
                          profileController.loginUser.value?.type ?? "",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.phone,
                              color: AppTheme.lightGrayTextColor,
                            ),
                            SizedBox(width: 10.w),
                            Obx(
                              () => Text(
                                profileController.loginUser.value?.phone ?? "",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.lightBlueTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.alternate_email,
                              color: AppTheme.lightGrayTextColor,
                            ),
                            SizedBox(width: 10.w),
                            Obx(
                              () => Text(
                                profileController.loginUser.value?.email ?? "",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.lightBlueTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Container(
                        width: double.infinity,
                        height: 1.h,
                        color: AppTheme.lightParticlesColor,
                      ),
                      SizedBox(height: 25.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.edit_profile)!
                                .then((value) {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.edit,
                                color: AppTheme.lightGrayTextColor,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.lightGrayTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: GestureDetector(
                          onTap: () {
                            profileController.logout();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.logout,
                                color: AppTheme.lightGrayTextColor,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.lightGrayTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.lightWhite50,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.w,
                    ),
                  ),
                  child: Obx(
                    () => ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: (profileController.loginUser.value?.image ?? "").isEmpty ?
                            "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png" : "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
                        placeholder: (context, url) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.grey.shade300,
                        ),
                        errorWidget: (context, url, error) =>
                            Center(child: Image.asset(placeHolderUser)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
