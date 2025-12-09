import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _keyToken = 'token';
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyUserName = 'user_name';
  static const _keyDriverId = 'driver_id';      // ⭐ NEW

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // 🔹 In-memory cache
  static String? _cachedToken;
  static String? _cachedDriverId;               // ⭐ NEW

  /// ✅ Save token securely
  static Future<void> saveSession({
    required String token,
    required String driverId,                   // ⭐ NEW
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyDriverId, driverId); // ⭐ Save driverId

    await _secureStorage.write(key: _keyToken, value: token);

    _cachedToken = token;
    _cachedDriverId = driverId;
  }

  /// ✅ Load session at app start
  static Future<void> initSession() async {
    _cachedToken = await _secureStorage.read(key: _keyToken);

    final prefs = await SharedPreferences.getInstance();
    _cachedDriverId = prefs.getString(_keyDriverId);

    if (_cachedToken == null) {
      _cachedToken = prefs.getString(_keyToken);
    }
  }

  /// ✅ Get token instantly
  static String? getToken() => _cachedToken;

  /// ✅ Get driverId instantly
  static String? getDriverId() => _cachedDriverId;

  /// ✅ Check login state
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// ❌ Clear session data
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _secureStorage.deleteAll();

    _cachedToken = null;
    _cachedDriverId = null;
  }
}
