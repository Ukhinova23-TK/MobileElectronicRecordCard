import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

import '../../../model/model.dart';
import '../mapper.dart';

class UserMapper implements Mapper<UserEntity, User> {
  @override
  UserEntity toEntity(User model) {
    return UserEntity(
      id: model.id,
      login: model.login,
      lastName: model.last_name,
      firstName: model.first_name,
      middleName: model.middle_name,
      groupId: model.groupId
    );
  }

  @override
  User toModel(UserEntity entity) {
    return User(
      id: entity.id,
      login: entity.login,
      last_name: entity.lastName,
      first_name: entity.firstName,
      middle_name: entity.middleName,
      groupId: entity.groupId
    );
  }

}