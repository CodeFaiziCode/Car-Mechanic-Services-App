// import 'package:car_fix_up/Routes/routes.dart';
// import 'package:car_fix_up/resources/constatnt.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:flutter_animation_check/webview/web_view.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   late PageController _controller;

//   @override
//   void initState() {
//     super.initState();

//     // DependencyInjection.init();

//     _controller = PageController();
//   }

//   int _currentPage = 0;

//   AnimatedContainer _buildDots({
//     int? index,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(
//           Radius.circular(50),
//         ),
//         color: kPrimaryColor,
//       ),
//       margin: const EdgeInsets.only(right: 5),
//       height: 10,
//       curve: Curves.easeIn,
//       width: _currentPage == index ? 20 : 10,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     double width = SizeConfig.screenW!;
//     double height = SizeConfig.screenH!;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: PageView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 controller: _controller,
//                 onPageChanged: (value) => setState(() => _currentPage = value),
//                 itemCount: contents.length,
//                 itemBuilder: (context, i) {
//                   return Padding(
//                     padding: const EdgeInsets.all(40.0),
//                     child: Column(
//                       children: [
//                         // SizedBox(
//                         //   height: SizeConfig.blockV! * 35,
//                         // ),
//                         // Image.asset(
//                         //   contents[i].image,
//                         //   height: SizeConfig.blockV! * 35,
//                         // ),
//                         // Lottie.asset(
//                         //   contents[i].animation,
//                         //   height: SizeConfig.blockV! * 35,
//                         // ),
//                         SvgPicture.asset(
//                           contents[i].animation,
//                           height: SizeConfig.blockV! * 35,
//                         ),

//                         SizedBox(
//                           height: (height >= 840) ? 60 : 30,
//                         ),
//                         Text(
//                           contents[i].title,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontFamily: "Mulish",
//                             fontWeight: FontWeight.w600,
//                             fontSize: (width <= 550) ? 30 : 35,
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         Text(
//                           contents[i].desc,
//                           style: TextStyle(
//                             fontFamily: "Mulish",
//                             fontWeight: FontWeight.w300,
//                             fontSize: (width <= 550) ? 17 : 25,
//                           ),
//                           textAlign: TextAlign.center,
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       contents.length,
//                       (int index) => _buildDots(
//                         index: index,
//                       ),
//                     ),
//                   ),
//                   _currentPage + 1 == contents.length
//                       ? Padding(
//                           padding: const EdgeInsets.all(30),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Get.offAllNamed(RouteName.login);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: kPrimaryColor,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               padding: (width <= 550)
//                                   ? const EdgeInsets.symmetric(
//                                       horizontal: 100, vertical: 20)
//                                   : EdgeInsets.symmetric(
//                                       horizontal: width * 0.2, vertical: 25),
//                               textStyle:
//                                   TextStyle(fontSize: (width <= 550) ? 13 : 17),
//                             ),
//                             child: Text(
//                               "Get Started",
//                               style: GoogleFonts.oxanium(
//                                   color: Colors.white,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.all(30),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   Get.offAllNamed(RouteName.login);
//                                 },
//                                 style: TextButton.styleFrom(
//                                   elevation: 0,
//                                   textStyle: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: (width <= 550) ? 13 : 17,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   "SKIP",
//                                   style: GoogleFonts.oxanium(
//                                       color: kPrimaryColor,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   _controller.nextPage(
//                                     duration: const Duration(milliseconds: 200),
//                                     curve: Curves.easeIn,
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: kPrimaryColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                   elevation: 0,
//                                   padding: (width <= 550)
//                                       ? const EdgeInsets.symmetric(
//                                           horizontal: 30, vertical: 20)
//                                       : const EdgeInsets.symmetric(
//                                           horizontal: 30, vertical: 25),
//                                   textStyle: TextStyle(
//                                       fontSize: (width <= 550) ? 13 : 17),
//                                 ),
//                                 child: Text("NEXT",
//                                     style: GoogleFonts.oxanium(
//                                         color: Colors.white,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                             ],
//                           ),
//                         )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OnboardingContents {
//   final String title;
//   final String animation;
//   final String desc;

//   OnboardingContents({
//     required this.title,
//     required this.animation,
//     required this.desc,
//   });
// }

// List<OnboardingContents> contents = [
//   OnboardingContents(
//     // Represent different workshop reliable vendors for repair
//     title: "Find the Best Repair Workshops",
//     animation: "assets/onboard/best-repair.svg",
//     desc:
//         "Discover reliable vendors for car repairs and maintenance. Ensure your vehicle is in the best hands.",
//   ),
//   OnboardingContents(
//     // Represent saving time by scheduling appointments and money by best rates on parts
//     title: "Save Money & Time",
//     animation: "assets/onboard/time-money-save.svg",
//     desc:
//         "Schedule appointments easily and get the best rates on car parts. Save both time and money.",
//   ),
//   OnboardingContents(
//     // This represents live diagnostics on video call and chat with real-time estimates
//     title: "Live Diagnostics",
//     animation: "assets/onboard/onboard-dignostic.svg",
//     desc:
//         "Experience live diagnostics via video call and chat. Get real-time estimates and expert advice.",
//   ),
// ];

// class SizeConfig {
//   static MediaQueryData? _mediaQueryData;
//   static double? screenW;
//   static double? screenH;
//   static double? blockH;
//   static double? blockV;

//   void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     screenW = _mediaQueryData!.size.width;
//     screenH = _mediaQueryData!.size.height;
//     blockH = screenW! / 100;
//     blockV = screenH! / 100;
//   }
// }

import 'package:car_fix_up/Routes/routes.dart';
import 'package:car_fix_up/controller/user_controller.dart';
import 'package:car_fix_up/resources/constatnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  late Timer _timer;
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < contents.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: kPrimaryColor,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 40.0, left: 40, top: 20, bottom: 20),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            contents[i].animation,
                            height: SizeConfig.blockV! * 35,
                          ),
                          SizedBox(
                            height: (height >= 840) ? 30 : 10,
                          ),
                          Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 30.sp : 35.sp,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            contents[i].desc,
                            style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w300,
                              fontSize: (width <= 550) ? 17.sp : 25.sp,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (int index) => _buildDots(index: index),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const Text(
                          "Are You?",
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                            onTap: () {
                              userController.userType = UserType.user;
                              Get.offAllNamed(RouteName.login);
                            },
                            child: Container(
                              height: 50.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Customer",
                                      style: GoogleFonts.oxanium(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 10),
                        InkWell(
                            onTap: () {
                              userController.userType = UserType.vendor;
                              Get.offAllNamed(RouteName.login);
                            },
                            child: Container(
                              height: 50.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/car-repair (4) 1.png",
                                      height: 21,
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Vendor",
                                      style: GoogleFonts.oxanium(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContents {
  final String title;
  final String animation;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.animation,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Find the Best Repair Workshops",
    animation: "assets/onboard/best-repair.svg",
    desc:
        "Discover reliable vendors for car repairs and maintenance. Ensure your vehicle is in the best hands.",
  ),
  OnboardingContents(
    title: "Save Money & Time",
    animation: "assets/onboard/time-money-save.svg",
    desc:
        "Schedule appointments easily and get the best rates on car parts. Save both time and money.",
  ),
  OnboardingContents(
    title: "Live Diagnostics",
    animation: "assets/onboard/onboard-dignostic.svg",
    desc:
        "Experience live diagnostics via video call and chat. Get real-time estimates and expert advice.",
  ),
];

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  static double? blockH;
  static double? blockV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    blockH = screenW! / 100;
    blockV = screenH! / 100;
  }
}
