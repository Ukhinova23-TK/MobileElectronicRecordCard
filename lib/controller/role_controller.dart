import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/role_name.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/role_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/role_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/role_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class RoleController {
  Future<List<RoleEntity>> get marks => getAllFromDb();

  Future<List<RoleEntity>> getAllFromDb() async {
    Mapper<RoleEntity, Role> roleMapper = RoleMapper();
    return (await RoleRepositoryImpl().getAll())
        .map((mark) => roleMapper.toEntity(mark))
        .toList();
  }

  Future<void> setAllToDb(List<RoleEntity> roles) async {
    RoleRepository roleRepository = RoleRepositoryImpl();
    for (var e in roles) {
      roleRepository.save(RoleMapper().toModel(e));
    }
  }

  Future<List<String?>> getStudentTeacherRoleFromDb(
      List<dynamic> rolesId) async {
    RoleRepository roleRepository = RoleRepositoryImpl();
    List<Future<Role?>> futureRoles =
        rolesId.map((id) => roleRepository.getByUserId(id)).toList();
    List<String?> roles = [];
    for (var i = 0; i < futureRoles.length; i++) {
      roles.add((await futureRoles[i])?.name);
    }

    return roles
        .where((element) =>
            element != null &&
            (element == RoleName.student || element == RoleName.teacher))
        .toList();
  }
}
