import 'package:app_chat/controllers/forgot_password_controller.dart';
import 'package:app_chat/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final controller = Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        iconSize: 33,
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Masukkan email anda untuk menerima link reset password",
                    style: TextStyle(color: AppTheme.textSecondaryColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        size: 38,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () {
                      if (controller.emailSent) {
                        return _buildEmailSendContent(controller);
                      } else {
                        {
                          return _buildEmailForm(controller);
                          // return _buildEmailSendContent(controller);
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm(ForgotPasswordController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email_outlined),
              hintText: "Masukkan email anda",
              hintStyle: TextStyle(color: Colors.grey)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: controller.validateEmail,
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: controller.isLoading
                      ? null
                      : controller.sendPasswordResetEmail,
                  label: Text(controller.isLoading
                      ? "Mengirim..."
                      : "Kirim Link Reset"),
                  icon: controller.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.whitePrimary,
                          ),
                        )
                      : const Icon(Icons.send)),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ingat password anda?",
              style: TextStyle(color: AppTheme.textPrimaryColor),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: controller.goBackToLogin,
              child: const Text(
                "Login",
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildEmailSendContent(ForgotPasswordController controller) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppTheme.succesColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: AppTheme.succesColor.withOpacity(0.1))),
            child: Column(
              children: [
                const Icon(
                  Icons.mark_email_read_outlined,
                  size: 45,
                  color: AppTheme.succesColor,
                ),
                Text(
                  "Email Terkirim!",
                  style: Theme.of(Get.context!)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                          color: AppTheme.succesColor,
                          fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kami sudah mengirim link ke :",
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppTheme.textSecondaryColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  controller.emailController.text,
                  style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Silahkan cek anda dan ikuti intruksi untuk reset password",
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppTheme.textSecondaryColor),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              onPressed: controller.resendEmail,
              icon: Icon(Icons.refresh_rounded),
              label: const Text("Kirim Ulang Email")),
        ),
        SizedBox(
          height: 13,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              onPressed: controller.goBackToLogin,
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              label: const Text("Kembali Login")),
        ),
        SizedBox(
          height: 23,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: AppTheme.secondaryColor,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Text(
                "Tidak Menerima email?, Cek ke folder spam atau coba lagi!",
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppTheme.secondaryColor),
              ))
            ],
          ),
        )
      ],
    );
  }
}
