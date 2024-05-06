import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';

abstract class RoleHttpClient {
  Future<List<RoleEntity>> getAll();
}
