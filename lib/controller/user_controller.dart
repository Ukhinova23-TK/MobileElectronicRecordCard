import 'package:flutter_logcat/log/log.dart';
import 'package:mobile_electronic_record_card/client/impl/user_http_client_impl.dart';
import 'package:mobile_electronic_record_card/controller/delete_controller.dart';
import 'package:mobile_electronic_record_card/controller/role_controller.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/authenticate_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/role_name.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/role_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/user_repository.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/role_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/user_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class UserController implements DeleteController {
  final sharedPrefLocator = getIt.get<SharedPreferenceHelper>();
  final secureStorageLocator = getIt.get<SecureStorageHelper>();
  Future<List<UserEntity>> get users => getAllFromDb();

  Future<List<UserEntity>> getAllFromDb() async {
    Mapper<UserEntity, User> userMapper = UserMapper();
    return (await UserRepositoryImpl().getAll())
        .map((user) => userMapper.toEntity(user))
        .toList();
  }

  Future<List<UserEntity>?> getByRoleFromDb(int roleId) async {
    Mapper<UserEntity, User> userMapper = UserMapper();
    return (await RoleRepositoryImpl().getUsers(roleId))
        ?.map((user) => userMapper.toEntity(user))
        .toList();
  }

  Future<List<UserEntity>>? getStudentsByGroupAndSubjectFromDb(
      int groupId, int subjectId) async {
    Mapper<UserEntity, User> userMapper = UserMapper();
    return (await UserRepositoryImpl()
            .getStudentsByGroupAndSubject(groupId, subjectId))
        .map((user) => userMapper.toEntity(user))
        .toList();
  }

  Future<List<UserEntity>?> getStudentsFromDb(int groupId) async {
    Mapper<UserEntity, User> userMapper = UserMapper();
    Role? role = await RoleRepositoryImpl().getByName(RoleName.student);
    if (role != null) {
      return (await RoleRepositoryImpl().getUsers(role.id!))
          ?.map((user) => userMapper.toEntity(user))
          .where((userEntity) => userEntity.groupId == groupId)
          .toList();
    }
    return null;
  }

  Future<List<UserEntity>?> getTeachersFromDb() async {
    Mapper<UserEntity, User> userMapper = UserMapper();
    Role? role = await RoleRepositoryImpl().getByName(RoleName.teacher);
    if (role != null) {
      return (await RoleRepositoryImpl().getUsers(role.id!))
          ?.map((user) => userMapper.toEntity(user))
          .toList();
    }
    return null;
  }

  Future<List<RoleEntity>?> getRolesFromDb(int id) async {
    Mapper<RoleEntity, Role> roleMapper = RoleMapper();
    return (await UserRepositoryImpl().getRoles(id))
        ?.map((role) => roleMapper.toEntity(role))
        .toList();
  }

  Future<void> getAllFromServer() async {
    return UserHttpClientImpl().getAll().then((value) => setAllToDb(value)
        .then((value) =>
        Log.i('Data received into db', tag: 'user_controller'))
        .catchError((e) => Log.e(e, tag: 'user_controller'))
        .catchError((e) => Log.e(e, tag: 'user_controller')));
  }

  Future<void> setAllToDb(List<UserEntity> users) async {
    UserRepository userRepository = UserRepositoryImpl();
    for (var element in users) {
      userRepository.save(UserMapper().toModel(element));
    }
  }

  Future<void> setUserToDb(UserEntity user) async {
    UserRepository userRepository = UserRepositoryImpl();
    userRepository.save(UserMapper().toModel(user));
  }

  Future<UserEntity> getByLoginFromServer(String login) async {
    UserEntity user = await UserHttpClientImpl().getByLogin(login);

    sharedPrefLocator.setUserId(user.id!);
    if (user.groupId != null) {
      sharedPrefLocator.setGroupId(user.groupId!);
    }
    if (user.roles != null) {
      await RoleController()
          .getStudentTeacherRoleFromDb(user.roles!)
          .then((roles) {
        if (roles.isNotEmpty) {
          List<String> r = [];
          for (var element in roles) {
            r.add(element!);
          }
          sharedPrefLocator.setRolesCount(roles.length);
          sharedPrefLocator.setRolesName(r);
        }
      });
    }
    return user;
  }

  Future<void> authenticate(String login, String password) async {
    await UserHttpClientImpl()
        .authenticate(AuthenticateEntity(login, password).toJson())
        .then((value) {
      secureStorageLocator
          .writeToken(AuthenticateEntity.fromJson(value).token!);
    });
  }

  @override
  Future<void> delete(int id) async {
    await UserRepositoryImpl().delete(id);
  }

  Future<void> deleteAll() async {
    await UserRepositoryImpl().deleteAll();
  }
}
