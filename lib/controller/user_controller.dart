import 'package:mobile_electronic_record_card/client/impl/user_http_client_impl.dart';
import 'package:mobile_electronic_record_card/controller/delete_controller.dart';
import 'package:mobile_electronic_record_card/controller/role_controller.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/authenticate_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_and_group_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/user_repository.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
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

  Future<List<UserEntity>>? getStudentsByGroupAndSubjectFromDb(
      int groupId, int subjectId) async {
    Mapper<UserEntity, User> userMapper = UserMapper();
    return (await UserRepositoryImpl()
            .getStudentsByGroupAndSubject(groupId, subjectId))
        .map((user) => userMapper.toEntity(user))
        .toList();
  }

  Future<void> setAllToDb(List<UserEntity> users) async {
    UserRepository userRepository = UserRepositoryImpl();
    for (var element in users) {
      userRepository.save(UserMapper().toModel(element));
    }
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

  Future<UserAndGroupEntity> getCurrentUserFromDb(int userId) async {
    UserAndGroupEntity u =
     (await UserRepositoryImpl()
        .getUser(userId))
        .map((e) => UserAndGroupEntity.fromJson(e))
        .toList().first;
    return u;
  }

  @override
  Future<void> delete(int id) async {
    await UserRepositoryImpl().delete(id);
  }

  Future<void> deleteAll() async {
    await UserRepositoryImpl().deleteAll();
  }
}
