import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/edit_profile/edit_profile_screen.dart';
import 'package:servefirst_admin/view/profile/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      return GetBuilder<ProfileController>(
        builder: (controller) => Scaffold(
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
                    left: isPortrait ? 25.w : 12.5.w,
                    right: isPortrait ? 25.w : 12.5.w,
                    top: statusBarHeight + (isPortrait ? 15.h : 30.h),
                    bottom: isPortrait ? 25.h : 50.h),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: isPortrait ? 60.h : 120.h, bottom: isPortrait ? 100.h : 120.h),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(isPortrait ? 12.r : 24.r)),
                            child: Column(
                              children: [
                                SizedBox(height: isPortrait ? 70.h : 120.h),
                                Obx(
                                  () => Text(
                                    controller.loginUser.value?.name ?? "",
                                    style: TextStyle(fontSize: isPortrait ? 24.sp : 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: isPortrait ? 5.h : 10.h),
                                Obx(
                                  () => Text(
                                    controller.loginUser.value?.type ?? "",
                                    style: TextStyle(fontSize: isPortrait ? 20.sp : 14.sp, fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(height: isPortrait ? 20.h : 40.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: isPortrait ? 50.w : 25.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppTheme.lightGrayTextColor,
                                      ),
                                      SizedBox(width: isPortrait ? 10.w : 5.w),
                                      Obx(
                                        () => Text(
                                          controller.loginUser.value?.phone ?? "",
                                          style: TextStyle(
                                              fontSize: isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w400, color: AppTheme.lightBlueTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: isPortrait ? 15.h : 30.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: isPortrait ? 50.w : 25.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.alternate_email,
                                        color: AppTheme.lightGrayTextColor,
                                      ),
                                      SizedBox(width: isPortrait ? 10.w : 5.w),
                                      Obx(
                                        () => Text(
                                          controller.loginUser.value?.email ?? "",
                                          style: TextStyle(
                                              fontSize: isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w400, color: AppTheme.lightBlueTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: isPortrait ? 25.h : 50.h),
                                Container(
                                  width: double.infinity,
                                  height: isPortrait ? 1.h : 2.h,
                                  color: AppTheme.lightParticlesColor,
                                ),
                                SizedBox(height: isPortrait ? 25.h : 50.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: isPortrait ? 50.w : 25.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => const EditProfileScreen());
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: AppTheme.lightGrayTextColor,
                                        ),
                                        SizedBox(width: isPortrait ? 10.w : 5.w),
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                              fontSize: isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w400, color: AppTheme.lightGrayTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: isPortrait ? 15.h : 30.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: isPortrait ? 50.w : 25.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.logout();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: AppTheme.lightGrayTextColor,
                                        ),
                                        SizedBox(width: isPortrait ? 10.w : 5.w),
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                              fontSize: isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w400, color: AppTheme.lightGrayTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h)
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: isPortrait ? 120 : 150,
                            height: isPortrait ? 120 : 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.lightWhite50,
                              border: Border.all(
                                color: Colors.white,
                                width: isPortrait ? 1.w : 0.5.w,
                              ),
                            ),
                            child: Obx(
                              () => ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: (controller.loginUser.value?.image ?? "").isEmpty
                                      ? "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png"
                                      : controller.loginUser.value?.image ?? "",
                                  placeholder: (context, url) => Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    color: Colors.grey.shade300,
                                  ),
                                  errorWidget: (context, url, error) => Center(child: Image.asset(placeHolderUser)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
