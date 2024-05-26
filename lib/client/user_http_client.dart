import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

abstract class UserHttpClient {
  Future<List<UserEntity>> getAll();

  Future<UserEntity> getByLogin(String login);

  Future<Map<String, dynamic>> refreshToken(
      Map<String, dynamic> refreshToken);

  Future<void> logout();

  Future<Map<String, dynamic>> authenticate(Map<String, dynamic> cred);

  Future<void> changePassword(Map<String, dynamic> passwords);
}
