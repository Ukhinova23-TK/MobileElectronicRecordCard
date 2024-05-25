import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const String token = 'token';
  static const String refreshToken = 'refreshToken';

  final FlutterSecureStorage secureStorage;

  SecureStorageHelper({required this.secureStorage});

  Future<void> writeToken(String newToken) =>
      secureStorage.write(key: token, value: newToken);

  Future<String?> readToken() => secureStorage.read(key: token);

  Future<void> removeToken() => secureStorage.delete(key: token);

  Future<void> writeRefreshToken(String newRefreshToken) =>
      secureStorage.write(key: refreshToken, value: newRefreshToken);

  Future<String?> readRefreshToken() => secureStorage.read(key: refreshToken);

  Future<void> removeRefreshToken() => secureStorage.delete(key: refreshToken);

  Future<void> removeAll() => secureStorage.deleteAll();
}
