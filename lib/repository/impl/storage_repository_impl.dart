import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_electronic_record_card/repository/storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> saveSecureData(String token) async {
    _secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<String?> readSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> deleteSecureData(String token) async {
    await _secureStorage.delete(key: 'token');
  }

  @override
  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll();
  }
}
