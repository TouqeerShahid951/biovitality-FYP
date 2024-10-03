import 'package:firebase_auth/firebase_auth.dart';
import 'user_auth_service.dart';

class LoginService {
  final AuthService _authService = AuthService();

  Future<UserCredential?> login(String email, String password) async {
    try {
      return await _authService.login(email, password);
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      return await _authService.loginWithGoogle();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    try {
      return await _authService.checkIfUserExists(email);
    } catch (e) {
      throw e;
    }
  }
}