import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class LocalStorageAdapter implements LocalStorage {
  final SharedPreferences _prefs;

  LocalStorageAdapter(this._prefs);

  @override
  Future<void> save({required String key, required dynamic data}) async {
    if (data.runtimeType == String) {
        await _prefs.setString(key, data);
    }
    else {
      throw UnimplementedError("Method not supported");
    }
    
  }

}