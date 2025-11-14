import 'package:app_chat/controllers/auth_controller.dart';
import 'package:app_chat/routes/app_routes.dart';
import 'package:app_chat/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  bool _obsecurePassword = true;
  bool _obsecureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Form(
                  key: _formKey,
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
                            width: 25,
                          ),
                          const Text(
                            "Daftar akun",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Center(
                        child: Text(
                          "Isi detail anda untuk memulai!",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _displayNameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Nama",
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.person_outlined),
                            hintText: "Masukkan nama anda",
                            hintStyle: TextStyle(color: Colors.grey)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Masukkan Nama Anda";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
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
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Masukkan Password Anda";
                          }
                          if (value!.length <= 6) {
                            return "Password harus lebih dari 6 kata";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obsecureConfirmPassword,
                        obscuringCharacter: "-",
                        decoration: InputDecoration(
                          labelText: "Konfirmasi Password",
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.security_outlined),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecureConfirmPassword =
                                      !_obsecureConfirmPassword;
                                });
                              },
                              icon: _obsecureConfirmPassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined)),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Konfirmasi password anda!";
                          }
                          if (value != _passwordController.text) {
                            return "Password tidak sama";
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
                                              .registerInWithEmailAndPassword(
                                                  _emailController.text.trim(),
                                                  _passwordController.text,
                                                  _displayNameController.text);
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
                                    : const Text("Daftar Akun")),
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
                          const Text("Sudah Punya punya akun?"),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () => Get.offAllNamed(AppRoutes.login),
                            child: Text(
                              "Login",
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
