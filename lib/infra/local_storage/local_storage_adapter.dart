import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class LocalStorageAdapter implements LocalStorage {
  final SharedPreferences _prefs;

  LocalStorageAdapter(this._prefs);

  @override
  Future<void> save<T>({required String key, required T data}) async {
    if (T == String) {
      await _prefs.setString(key, data as String);
    } else {
      throw UnimplementedError("Method not supported");
    }    
  }

  @override
  Future<dynamic> get<T>({required String key}) async {
    if (T == String) {
      return _prefs.getString(key);
    } else {
      throw UnimplementedError("Method not supported");
    }  
  }

}