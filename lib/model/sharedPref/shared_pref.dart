import 'package:login/model/sharedPref/shared_pref_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends SharedPrefType {
  static const String _loginToken = "LOGIN_TOKEN";

  @override
  Future<void> saveLoginToken(String token) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(_loginToken, token);
  }

  @override
  Future<String> getLoginToken() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_loginToken) ?? "";
  }
}
