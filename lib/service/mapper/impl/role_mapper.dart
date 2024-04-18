import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';

import '../mapper.dart';

class RoleMapper implements Mapper<RoleEntity, Role> {
  @override
  RoleEntity toEntity(Role model) {
    return RoleEntity(
      id: model.id,
      name: model.name
    );
  }

  @override
  Role toModel(RoleEntity entity) {
    return Role(
      id: entity.id,
      name: entity.name
    );
  }

}