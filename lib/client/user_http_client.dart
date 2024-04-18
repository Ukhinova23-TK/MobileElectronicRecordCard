import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';

abstract class UserHttpClient {
  Future<List<RoleEntity>> getUserRoles(int id);
}