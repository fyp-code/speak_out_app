import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._internal();
  factory SharedPrefService() => _instance;
  SharedPrefService._internal();

  late SharedPreferences _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final _tokenKey = 'access-token';
  final name = 'name-user';
  final userTypeKey = 'type-user';

  String? get accessToken => _prefs.getString(_tokenKey);

  Future<bool> setAccessToken(String token) async {
    return await _prefs.setString(_tokenKey, token);
  }

  Future<void> saveUsername(String username) {
    return _prefs.setString(name, username);
  }

  String? get username => _prefs.getString(name);

  Future<bool> clearAllData() async {
    return await _prefs.clear();
  }

  String get getUserType => _prefs.getString(userTypeKey) ?? "";

  Future<void> saveUserType(String userType) {
    return _prefs.setString(userTypeKey, userType);
  }

  Future<void> removeUserType(String userType) {
    return _prefs.remove(userTypeKey);
  }
}
