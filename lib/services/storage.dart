import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Storage{
  static Future<void> setString(key, value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }
  static Future<void> setStringList(key, value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(key, value);
  }
  static Future<String> getString(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(key);
    return sp.getString(key);
  }
  static Future<List> getStringList(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(key);
    return sp.getStringList(key);
  }
  static Future<void> remove(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
  static Future<void> clear() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}