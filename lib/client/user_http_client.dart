import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

abstract class UserHttpClient {
  Future<List<RoleEntity>> getUserRoles(int id);

  Future<List<UserEntity>> getAll();

  Future<UserEntity> getByLogin(String login);

  Future<Map<String, dynamic>> authenticate(Map<String, dynamic> cred);
}