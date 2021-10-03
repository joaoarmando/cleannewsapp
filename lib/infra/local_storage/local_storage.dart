abstract class LocalStorage {
  Future<dynamic> get<T>({required String key});
  Future<void> save<T>({required String key, required dynamic data});
}