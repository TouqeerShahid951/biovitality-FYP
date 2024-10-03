import 'package:firebase_auth/firebase_auth.dart';
import 'admin_auth_service.dart';

class AdminLoginService {
  final AdminAuthService _authService = AdminAuthService();

  Future<UserCredential?> login(String email, String password) async {
    try {
      return await _authService.login(email, password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw e;
    }
  }
}