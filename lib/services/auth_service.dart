import 'package:app_chat/model/user_model.dart';
import 'package:app_chat/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _fireStoreService = FirestoreService();

  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;
  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await _fireStoreService.updateUserOnlineStatus(user.uid, true);
        return await _fireStoreService.getUser(user.uid);
      }
      return null;
    } catch (e) {
      throw Exception("Gagal Login : ${e.toString()} ");
    }
  }

  Future<UserModel?> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await user.updateDisplayName(displayName);
        final userModel = UserModel(
            id: user.uid,
            createAt: DateTime.now(),
            displayName: displayName,
            email: email,
            lastSeen: DateTime.now(),
            photoUrl: "",
            isOnline: true);
        await _fireStoreService.createUser(userModel);
        return userModel;
      }
      return null;
    } catch (e) {
      throw Exception("Gagal Register : ${e.toString()} ");
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(
          "Gagal Untuk Kirim Password Reset Email : ${e.toString()} ");
    }
  }

  Future<void> signOut() async {
    try {
      if (currentUser != null) {
        await _fireStoreService.updateUserOnlineStatus(currentUserId!, false);
      }
      await _auth.signOut();
    } catch (e) {
      throw Exception("Gagal Untuk LogOut: ${e.toString()} ");
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await _fireStoreService.deleteUser(user.uid);
        await user.delete();
      }
    } catch (e) {
      throw Exception("Gagal Untuk Hapus Akun: ${e.toString()} ");
    }
  }
}
