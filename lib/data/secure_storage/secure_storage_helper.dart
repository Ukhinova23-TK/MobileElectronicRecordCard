import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const String token = 'token';

  final FlutterSecureStorage secureStorage;

  SecureStorageHelper({required this.secureStorage});

  Future<void> writeToken(String newToken) =>
      secureStorage.write(key: token, value: newToken);

  Future<String?> readToken() => secureStorage.read(key: token);

  Future<void> removeToken() => secureStorage.delete(key: token);
}
