import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/svg_icon.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/dashboard/controller/dashboard_controller.dart';
import 'package:servefirst_admin/view/profile/profile_screen.dart';
import 'package:servefirst_admin/view/report/report_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      return GetBuilder<DashboardController>(
          builder: (controller) => WillPopScope(
                onWillPop: () async {
                  await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  return true;
                },
                child: Scaffold(
                  extendBody: true,
                  body: IndexedStack(
                    index: controller.tabIndex,
                    children: const [ReportScreen(), ProfileScreen()],
                  ),
                  bottomNavigationBar: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 0.5.h,
                        color: AppTheme.lightParticlesColor,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8.h),
                        color: Colors.white,
                        child: BottomNavigationBar(
                          backgroundColor: Colors.transparent,
                          onTap: (val) {
                            controller.updateIndex(val);
                          },
                          currentIndex: controller.tabIndex,
                          unselectedFontSize: isPortrait ? 12.sp : 6.sp,
                          selectedFontSize: isPortrait ? 12.sp : 6.sp,
                          type: BottomNavigationBarType.fixed,
                          selectedItemColor: AppTheme.lightPrimaryColor,
                          unselectedItemColor: AppTheme.lightAccentColor,
                          elevation: 0,
                          items: [
                            BottomNavigationBarItem(
                                icon: Container(padding: EdgeInsets.only(bottom: 6.h), child: SvgIcon(assetImage: icReport)), label: sReport),
                            BottomNavigationBarItem(
                                icon: Container(padding: EdgeInsets.only(bottom: 6.h), child: const Icon(Icons.account_circle_outlined)),
                                label: sProfile),
                          ],
                          selectedIconTheme: IconThemeData(
                            color: AppTheme.lightPrimaryColor,
                          ),
                          unselectedIconTheme: IconThemeData(color: AppTheme.lightAccentColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
    });
  }
}
