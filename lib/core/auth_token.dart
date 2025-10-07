import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  static final AuthToken instance = AuthToken._();
  AuthToken._();

  String? _token;
  String? get token => _token;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
  }

  Future<void> save(String? t) async {
    _token = t;
    final prefs = await SharedPreferences.getInstance();
    if (t == null) {
      await prefs.remove('auth_token');
    } else {
      await prefs.setString('auth_token', t);
    }
  }

  bool get isAuthenticated => (_token ?? '').isNotEmpty;
}
