import 'package:app_chat/controllers/auth_controller.dart';
import 'package:app_chat/routes/app_routes.dart';
import 'package:app_chat/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  bool _obsecurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
            child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.chat_bubble,
                            color: AppTheme.whitePrimary,
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "WELCOME!",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Login untuk memulai percakapan dengan teman & keluarga",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Masukkan email anda",
                            hintStyle: TextStyle(color: Colors.grey)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Masukkan Email Anda";
                          }
                          if (!GetUtils.isEmail(value!)) {
                            return "Masukkan Email Yang Valid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obsecurePassword,
                        obscuringCharacter: "-",
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.security_outlined),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecurePassword = !_obsecurePassword;
                                });
                              },
                              icon: _obsecurePassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Masukkan Password Anda";
                          }
                          if (value!.length <= 6) {
                            return "Password harus dari 6 kata";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _authController.isLoading
                                    ? null
                                    : () {
                                        // Data Harus ada makanya pakai !, bisa saja pakai ? dan harus direturn false jika null atau tidak ada data
                                        // _formKey.currentState?.validate() ?? false
                                        if (_formKey.currentState!.validate()) {
                                          _authController
                                              .signInWithEmailAndPassword(
                                                  _emailController.text.trim(),
                                                  _passwordController.text);
                                        }
                                      },
                                child: _authController.isLoading
                                    ? const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          color: AppTheme.whitePrimary,
                                          strokeWidth: 1.5,
                                        ),
                                      )
                                    : const Text("Login")),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Center(
                        child: TextButton(
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0)),
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: WidgetStateProperty.all(
                                Colors.black12, // 🔹 warna ripple
                              )),
                          onPressed: () {
                            print("Lupa password dia jir");
                            Get.toNamed(AppRoutes.forgotPassword);
                          },
                          child: const Text("Lupa Password?"),
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppTheme.borderColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Text(
                              "ATAU",
                              style:
                                  TextStyle(color: AppTheme.textSecondaryColor),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppTheme.borderColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Tidak punya akun?"),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.register),
                            child: Text(
                              "Daftar",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))),
      ),
    );
  }
}
