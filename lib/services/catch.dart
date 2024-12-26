import 'package:shared_preferences/shared_preferences.dart';

class CatchServices {
  final sharedpref = SharedPreferences.getInstance();
  Future<void> setString(String key, String value) async {
    final sharedPreferances = await sharedpref;
    sharedPreferances.setString(key, value);
  }
  Future<String ?> getString(String key) async {
    final sharedPreferances = await sharedpref;
   return  sharedPreferances.getString(key);
  } 
  
  
  Future<void> setBool(String key, bool value) async {
    final sharedPreferances = await sharedpref;
    sharedPreferances.setBool(key, value);
  }


  Future<bool ?> getBool(String key) async {
    final sharedPreferances = await sharedpref;
   return  sharedPreferances.getBool(key);
  }  
    Future<void> setInt(String key, int value) async {
    final sharedPreferances = await sharedpref;
    sharedPreferances.setInt(key, value);
  }


  Future<int ?> getInt(String key) async {
    final sharedPreferances = await sharedpref;
   return  sharedPreferances.getInt(key);
  } 
    Future<void> setDouble(String key, double value) async {
    final sharedPreferances = await sharedpref;
    sharedPreferances.setDouble(key, value);
  }


  Future<double ?> getDouble(String key) async {
    final sharedPreferances = await sharedpref;
   return  sharedPreferances.getDouble(key);
  } 
  



    Future<void> setStringList(String key, List<String> value) async {
    final sharedPreferances = await sharedpref;
    sharedPreferances.setStringList(key, value);
  }


  Future<List<String >?> getStringList(String key) async {
    final sharedPreferances = await sharedpref;
   return  sharedPreferances.getStringList(key);
  } 
      Future<void> remove(String key) async {
    final sharedPreferances = await sharedpref;
    sharedPreferances.remove(key);
  }  
    Future<void> clear() async {
    final sharedPreferances = await sharedpref;
    sharedPreferances.clear();
  }
}
