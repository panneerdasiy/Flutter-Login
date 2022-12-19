abstract class SharedPrefType{

  Future<void> saveLoginToken(String token);

  Future<String> getLoginToken();
}