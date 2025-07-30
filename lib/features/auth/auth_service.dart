// auth_service.dart: Kullanıcı token işlemleri için servis.
// SharedPreferences ile local storage işlemleri yapılır.

import 'package:shared_preferences/shared_preferences.dart';

// AuthService: Kullanıcı token'ını kaydetmek, almak ve silmek için kullanılır.
class AuthService {
  // Token'ı kaydeder.
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Token'ı okur.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Token'ı siler.
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}