import 'dart:developer';
import 'dart:io';

import 'package:car_fix_up/Routes/routes.dart';
import 'package:car_fix_up/resources/constatnt.dart';
import 'package:car_fix_up/services/local-storage/localStorage.dart';
import 'package:car_fix_up/views/User/chat/chat_screen.dart';
import 'package:car_fix_up/views/User/dashboard/controller/dashboard_controller.dart';
import 'package:car_fix_up/views/User/home/home_view.dart';
import 'package:car_fix_up/views/User/workshop/workshop_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    final PageController _pageController = PageController();
    final user = FirebaseAuth.instance.currentUser;
    return WillPopScope(
        onWillPop: () async {
          if (dashboardController.currentIndex.value == 0) {
            return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      backgroundColor: kPrimaryColor,
                      title: Text(
                        'Are you sure?',
                        style: GoogleFonts.oxanium(
                            color: kBlackColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      contentTextStyle: GoogleFonts.oxanium(
                          color: kBlackColor, fontSize: 16.sp),
                      content: const Text('Do you want to exit an App'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'No',
                              style: GoogleFonts.oxanium(
                                  color: kBlackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => exit(0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Yes',
                              style: GoogleFonts.oxanium(
                                  color: kBlackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ));
          } else {
            dashboardController.currentIndex.value = 0;
            return false;
          }
        },
        child: Scaffold(
          backgroundColor: kWhiteColor,
          drawer: Drawer(
            backgroundColor: kBlackColor.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: Center(
                    child: Text(
                      '${user!.email}',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Image.asset(kSideMenuBg,
                        fit: BoxFit.cover, width: 1.sw, height: 1.sh),
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.home_outlined,
                            color: kWhiteColor,
                          ),
                          title: Text(
                            'Home',
                            style: GoogleFonts.oxanium(
                                color: kWhiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            dashboardController.currentIndex.value = 0;
                            _pageController.jumpToPage(0);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.schedule_rounded,
                            color: kWhiteColor,
                          ),
                          title: Text(
                            'Schedule',
                            style: GoogleFonts.oxanium(
                                color: kWhiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            dashboardController.currentIndex.value = 1;
                            _pageController.jumpToPage(1);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.car_repair,
                            color: kWhiteColor,
                          ),
                          title: Text(
                            'Workshop',
                            style: GoogleFonts.oxanium(
                                color: kWhiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            dashboardController.currentIndex.value = 2;
                            _pageController.jumpToPage(2);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.person_outline,
                            color: kWhiteColor,
                          ),
                          title: Text(
                            'Profile',
                            style: GoogleFonts.oxanium(
                                color: kWhiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            dashboardController.currentIndex.value = 3;
                            _pageController.jumpToPage(3);
                            Navigator.pop(context);
                          },
                        ),
                        const Spacer(),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: kWhiteColor,
                          ),
                          title: Text(
                            'Logout',
                            style: GoogleFonts.oxanium(
                                color: kWhiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () async {
                            LocalStorageService().clearAll();
                            await FirebaseAuth.instance.signOut();
                            Get.offAllNamed(RouteName.login);
                          },
                        ),
                      ],
                    )
                  ],
                )),
              ],
            ),
          ),
          body: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  dashboardController.changeIndex(index);
                },
                children: const [
                  HomeView(),
                  ChatView(),
                  WorkshopView(),
                  ChatView()
                ],
              ),
              // Custom floating bottom bar with animated page indicator
              Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 50.h,
                      width: 1.sh,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [kBlackColor, Colors.grey[800]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: kBlackColor.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildNavItem(
                                  icon: kHomeIcon,
                                  index: 0,
                                  controller: dashboardController,
                                  pageController: _pageController),
                              _buildNavItem(
                                  icon: kScheduledIcon,
                                  index: 1,
                                  controller: dashboardController,
                                  pageController: _pageController),
                              _buildNavItem(
                                  icon: kdignosticIcon,
                                  index: 2,
                                  controller: dashboardController,
                                  pageController: _pageController),
                              _buildNavItem(
                                  icon: kCarRepairIcon,
                                  index: 3,
                                  controller: dashboardController,
                                  pageController: _pageController),
                            ],
                          )),
                    ),
                  )),
              //SOS Button
              Positioned(
                bottom: 80,
                right: 20,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(RouteName.videoCall, arguments: "sos_call");
                  }, //SOS Call
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: kBlackColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [kBlackColor, Colors.grey[800]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SvgPicture.asset(kSOSIcon, height: 30, width: 30),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildNavItem(
      {required String icon,
      required int index,
      required DashboardController controller,
      required PageController pageController}) {
    return InkWell(
      onTap: () {
        pageController.jumpToPage(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: 30,
            width: 30,
            color: controller.currentIndex.value == index
                ? kPrimaryColor
                : kWhiteColor,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: 5,
            width: controller.currentIndex.value == index ? 20 : 0,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ],
      ),
    );
  }
}
