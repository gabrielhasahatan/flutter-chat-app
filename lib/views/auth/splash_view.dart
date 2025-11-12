import 'package:app_chat/controllers/auth_controller.dart';
import 'package:app_chat/routes/app_routes.dart';
import 'package:app_chat/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _lateAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    await Future.delayed(Duration(seconds: 2));

    final authController = Get.put(AuthController(), permanent: true);
    // authController.deleteAccount();
    await Future.delayed(Duration(milliseconds: 500));

    if (authController.isAuthenticated) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppTheme.whitePrimary,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.chat_bubble_rounded,
                          size: 65,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Text("MY CHAT APP GW",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: AppTheme.whitePrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Made By Me",
                        style: TextStyle(
                          color: AppTheme.textPrimaryColor.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(
                        color: AppTheme.whitePrimary,
                        strokeWidth: 2,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
