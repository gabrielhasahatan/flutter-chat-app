import 'package:app_chat/routes/app_routes.dart';
import 'package:app_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _emailSent = false.obs;

  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get emailSent => _emailSent.value;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendPasswordResetEmail() async {
    if (!formKey.currentState!.validate()) return;
    try {
      _isLoading.value = true;
      _error.value = '';
      await _authService.sendPasswordResetEmail(emailController.text.trim());
      _emailSent.value = true;
      Get.snackbar("Success",
          "Reset Password telah dikirim ke email : ${emailController.text.trim()}",
          backgroundColor: Colors.green.withOpacity(0.3),
          colorText: Colors.green,
          duration: const Duration(seconds: 3));
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan : ${e.toString()}",
          backgroundColor: Colors.red.withOpacity(0.3),
          colorText: Colors.red,
          duration: const Duration(seconds: 4));
    } finally {
      _isLoading.value = false;
    }
  }

  void goBackToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  void resendEmail() {
    _emailSent.value = false;
    sendPasswordResetEmail();
  }

  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return "Masukkan Email Anda";
    }
    if (!GetUtils.isEmail(value!)) {
      return "Masukkan Email Valid";
    }
    return null;
  }

  void _clearError() {
    _error.value = '';
  }
}
