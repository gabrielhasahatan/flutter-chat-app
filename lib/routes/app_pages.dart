import 'package:app_chat/routes/app_routes.dart';
import 'package:app_chat/views/auth/login_view.dart';
import 'package:app_chat/views/auth/main_view.dart';
import 'package:app_chat/views/auth/register_view.dart';
import 'package:app_chat/views/auth/splash_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.login, page: () => const LoginView()),
    GetPage(name: AppRoutes.register, page: () => const RegisterView()),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
    )
    // GetPage(name: AppRoutes.home, page: () => const,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // ) ),
    // GetPage(name: AppRoutes.main, page: () => const ,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // )),
    // GetPage(name: AppRoutes.forgotPassword, page: () => const,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // ) ),
    // GetPage(name: AppRoutes.changePassword, page: () => const,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // ) ),
    // GetPage(name: AppRoutes.chat, page: () => const,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // ) ),
    // GetPage(name: AppRoutes.profile, page: () => const,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // ) ),
    // GetPage(name: AppRoutes.usersList, page: () => const,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // ) ),
    // GetPage(name: AppRoutes.friends, page: () => const,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // )),
    // GetPage(name: AppRoutes.friendRequest, page: () => const ,
    // binding: BindingsBuilder(
    //   (){
    //     Get.put();
    //   }
    // )),
    // GetPage(name: AppRoutes.notification , page: () => const,
    // binding: BindingsBuilder(
    //   Get.put(

    //   )
    // ) ),
  ];
}
