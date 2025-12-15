import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _keyToken = 'token';
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyUserName = 'user_name';
  static const _keyDriverId = 'driver_id';
  static const _keyFcmToken = 'fcm_token'; // ⭐ NEW
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // 🔹 In-memory cache
  static String? _cachedToken;
  static String? _cachedDriverId;
  static String? _cachedFcmToken; // ⭐ NEW

  /// Save token & driverId securely
  static Future<void> saveSession({
    required String token,
    required String driverId,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyDriverId, driverId);

    await _secureStorage.write(key: _keyToken, value: token);

    _cachedToken = token;
    _cachedDriverId = driverId;
  }

  /// Save FCM token
  static Future<void> saveFcmToken(String fcmToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFcmToken, fcmToken);
    _cachedFcmToken = fcmToken;
  }

  /// Load session at app start
  static Future<void> initSession() async {
    _cachedToken = await _secureStorage.read(key: _keyToken);

    final prefs = await SharedPreferences.getInstance();
    _cachedDriverId = prefs.getString(_keyDriverId);
    _cachedFcmToken = prefs.getString(_keyFcmToken); // ⭐ Load FCM

    if (_cachedToken == null) {
      _cachedToken = prefs.getString(_keyToken);
    }
  }

  /// Getters
  static String? getToken() => _cachedToken;
  static String? getDriverId() => _cachedDriverId;
  static String? getFcmToken() => _cachedFcmToken; // ⭐ NEW

  /// Check login state
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Clear session data
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _secureStorage.deleteAll();

    _cachedToken = null;
    _cachedDriverId = null;
    _cachedFcmToken = null; // ⭐ Clear FCM
  }
}
