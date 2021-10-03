import 'package:cleannewsapp/infra/local_storage/local_storage_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_adapter_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late SharedPreferences prefs;
  late LocalStorageAdapter localStorage;

  setUp(() {
    prefs = MockSharedPreferences();
    localStorage = LocalStorageAdapter(prefs);
  });

  test('Should save a string on a storage', () async {
    when(prefs.setString("any_key", "any_value")).thenAnswer((_) async => true);

    await localStorage.save(key: "any_key", data: "any_value");

    verify(prefs.setString("any_key", "any_value"));
  });

  test('Should restore a string on a storage', () async {
    when(prefs.getString("any_key")).thenReturn("any_saved_value");

    final result = await localStorage.get<String>(key: "any_key");

    verify(prefs.getString("any_key"));
    expect(result, equals("any_saved_value"));
  });
}