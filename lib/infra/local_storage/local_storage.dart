abstract class LocalStorage {
  Future<dynamic> get<T>({required String key});
  Future<void> save({required String key, required dynamic data});
}