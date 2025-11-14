import 'package:app_chat/controllers/profile_controller.dart';
import 'package:app_chat/model/user_model.dart';
import 'package:app_chat/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          Obx(() => TextButton(
              onPressed: controller.isEditing
                  ? controller.toggleEditing
                  : controller.toggleEditing,
              child: Text(
                controller.isEditing ? "Cancel" : "Edit",
                style: TextStyle(
                    color: controller.isEditing
                        ? AppTheme.errorColor
                        : AppTheme.primaryColor),
              )))
        ],
      ),
      body: Obx(() {
        final user = controller.currentUser;
        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppTheme.primaryColor,
                        child: user.photoUrl.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  user.photoUrl,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildDefaultAvatar(user);
                                  },
                                ),
                              )
                            : _buildDefaultAvatar(user),
                      ),
                      if (controller.isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.textPrimaryColor,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: AppTheme.cardColor, width: 1)),
                            child: IconButton(
                              onPressed: () {
                                Get.snackbar(
                                    "Info", "Update Foto Segera Hadir");
                              },
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                                color: AppTheme.cardColor,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    user.displayName,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    user.email,
                    style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: AppTheme.textSecondaryColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: user.isOnline
                          ? AppTheme.succesColor.withOpacity(0.1)
                          : AppTheme.textSecondaryColor.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: user.isOnline
                                  ? AppTheme.succesColor
                                  : AppTheme.textSecondaryColor,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          user.isOnline ? 'Online' : 'Offline',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: user.isOnline
                                      ? AppTheme.succesColor
                                      : AppTheme.textSecondaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    controller.getJoinedData(),
                    style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Obx(
                () {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Informasi Pribadi",
                            style: Theme.of(Get.context!)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.displayNameController,
                            enabled: controller.isEditing,
                            decoration: InputDecoration(
                                labelText: "Display Name",
                                prefixIcon: Icon(Icons.people_outline)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 15),
                            controller: controller.emailController,
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email_outlined),
                                helperText: "Email tidak dapat diubah"),
                          ),
                          if (controller.isEditing) ...[
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: controller.isLoading
                                      ? null
                                      : controller.updateProfile,
                                  child: controller.isLoading
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppTheme.whitePrimary,
                                          ),
                                        )
                                      : Text("Simpan Perubahan")),
                            )
                          ]
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }

  _buildDefaultAvatar(UserModel user) {
    return Text(
      user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 35,
      ),
    );
  }
}
