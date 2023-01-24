import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';
  }
}
