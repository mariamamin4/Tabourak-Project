import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static const FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  static Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  static Future<void> removeSecuredData(String key) async {
    debugPrint('SharedPrefHelper : secured data with key : $key has been removed');
    try {
      if (kIsWeb) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance().timeout(const Duration(seconds: 5));
        await sharedPreferences.remove(key);
      } else {
        await _flutterSecureStorage.delete(key: key).timeout(const Duration(seconds: 5));
      }
    } catch (e) {
      debugPrint('Error in removeSecuredData: $e');
      rethrow;
    }
  }

  static Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> clearAllSecuredData() async {
    debugPrint('SharedPrefHelper : all secured data has been cleared');
    try {
      if (kIsWeb) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance().timeout(const Duration(seconds: 5));
        await sharedPreferences.clear();
      } else {
        await _flutterSecureStorage.deleteAll().timeout(const Duration(seconds: 5));
      }
    } catch (e) {
      debugPrint('Error in clearAllSecuredData: $e');
      rethrow;
    }
  }

  static Future<void> setData(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case String:
        await sharedPreferences.setString(key, value);
        break;
      case int:
        await sharedPreferences.setInt(key, value);
        break;
      case bool:
        await sharedPreferences.setBool(key, value);
        break;
      case double:
        await sharedPreferences.setDouble(key, value);
        break;
      default:
        return;
    }
  }

  static Future<bool> getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  static Future<double> getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  static Future<int> getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  static Future<String> getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  static Future<void> setSecuredString(String key, String value) async {
    debugPrint("SharedPrefHelper : setSecuredString with key : $key and value : $value");
    try {
      if (kIsWeb) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance().timeout(const Duration(seconds: 5));
        await sharedPreferences.setString(key, value);
      } else {
        await _flutterSecureStorage.write(key: key, value: value).timeout(const Duration(seconds: 5));
      }
    } catch (e) {
      debugPrint('Error in setSecuredString: $e');
      rethrow;
    }
  }

  static Future<String?> getSecuredString(String key) async {
    debugPrint('SharedPrefHelper : getSecuredString with key : $key');
    try {
      if (kIsWeb) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance().timeout(const Duration(seconds: 5));
        return sharedPreferences.getString(key) ?? '';
      } else {
        return await _flutterSecureStorage.read(key: key).timeout(const Duration(seconds: 5)) ?? '';
      }
    } catch (e) {
      debugPrint('Error in getSecuredString: $e');
      rethrow;
    }
  }
}