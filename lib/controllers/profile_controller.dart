import 'package:app_chat/controllers/auth_controller.dart';
import 'package:app_chat/model/user_model.dart';
import 'package:app_chat/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RxBool _isLoading = false.obs;
  RxBool _isEditing = false.obs;
  RxString _error = ''.obs;

  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);

  bool get isLoading => _isLoading.value;
  bool get isEditing => _isEditing.value;
  String get error => _error.value;
  UserModel? get currentUser => _currentUser.value;

  @override
  void onInit() {
    _loadUserData();
    super.onInit();
  }

  @override
  void onClose() {
    displayNameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void _loadUserData() {
    final currentUserId = _authController.user?.uid;
    if (currentUserId != null) {
      _currentUser.bindStream(_firestoreService.getUserStream(currentUserId));
    }

    ever(
      _currentUser,
      (UserModel? user) {
        if (user != null) {
          displayNameController.text = user.displayName;
          emailController.text = user.email;
        }
      },
    );
  }

  void toggleEditing() {
    _isEditing.value = !_isEditing.value;

    // Misal lagi toggle (true) = maka ini tidak dijalankan
    // Misal toggle lagi false alias tidak di edit maka, ini akan dijalankan dan fieldnya akan diisi oleh detail user
    if (!_isEditing.value) {
      final user = _currentUser.value;
      if (user != null) {
        displayNameController.text = user.displayName;
        emailController.text = user.email;
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      _isLoading.value = true;
      _error.value = '';
      final user = _currentUser.value;

      if (user == null) return;

      final updateUser = user.copyWith(
        displayName: displayNameController.text,
      );
      await _firestoreService.updateUser(updateUser);
      _isEditing.value = false;
      Get.snackbar("Succes", "Berhasil memperbaharui profile");
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar("Error", "Gagal untuk update user");
    } finally {
      _isEditing.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authController.signOut();
    } catch (e) {
      Get.snackbar("Error", "Gagal Logout");
    }
  }

  Future<void> deleteAccount() async {
    try {
      final result = await Get.dialog<bool>(
        AlertDialog(
          title: Text("Hapus Akun"),
          content: Text("Apakah anda yakin untuk mengapus akun?"),
          actions: [
            TextButton(
                onPressed: () => Get.back(result: false),
                child: Text("Cancel")),
            SizedBox(
              width: 10,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                ),
                onPressed: () => Get.back(result: true),
                child: const Text(
                  "Hapus",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      );
      if (result == true) {
        _isLoading.value = true;
        await _authController.deleteAccount();
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal hapus akun");
    }
  }

  String getJoinedData() {
    final user = _currentUser.value;
    if (user == null) return '';

    final date = user.createAt;
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return 'Bergabung ${months[date.month - 1]} ${date.year}';
  }

  void clearError() {
    _error.value = '';
  }
}
