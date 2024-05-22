import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

class UserAndGroupEntity {
  UserEntity user;
  GroupEntity? group;

  UserAndGroupEntity({required this.user, this.group});

  static UserAndGroupEntity fromJson(Map<String, dynamic> json) {
    return UserAndGroupEntity(
        user: UserEntity.fromJson(json, prefix: "user."),
        group: GroupEntity.fromJson(json, prefix: 'group.'));
  }
}
