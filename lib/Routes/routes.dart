import 'package:car_fix_up/views/User/auth/login_view.dart';
import 'package:car_fix_up/views/User/auth/signup_view.dart';
import 'package:car_fix_up/views/User/chat/chat_screen.dart';
import 'package:car_fix_up/views/User/dashboard/dashboard..dart';
import 'package:car_fix_up/views/components/onBoarding_screen.dart';
import 'package:car_fix_up/views/components/splash_screen.dart';
import 'package:car_fix_up/views/User/home/home_view.dart';
import 'package:car_fix_up/views/User/sos-video-call/sos_video_call_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> appRoute() {
    return [
      GetPage(
        name: RouteName.splash,
        page: (() => const SplashView()),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: RouteName.onboarding,
        page: (() => const OnboardingScreen()),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: RouteName.dashboard,
        page: (() => const DashboardView()),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: RouteName.login,
        page: (() => const LoginView()),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: RouteName.signup,
        page: (() => const SignupView()),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: RouteName.home,
        page: (() => const HomeView()),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: RouteName.videoCall,
        page: (() => SosVideoCalScreem(
              callId: Get.arguments,
            )),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: RouteName.chat,
        page: (() => const ChatView()),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
  }
}

class RouteName {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String videoCall = '/video-call';
  static const String chat = '/chat';
  static const String profile = '/profile';
}
