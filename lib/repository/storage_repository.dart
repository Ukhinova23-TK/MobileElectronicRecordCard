abstract class StorageRepository {
  Future<void> saveSecureData(String token);

  Future<String?> readSecureData(String key);

  Future<void> deleteSecureData(String token);

  Future<void> deleteAllSecureData();
}