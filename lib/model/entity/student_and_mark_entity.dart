import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

class StudentAndMarkEntity {
  UserEntity user;
  MarkEntity? mark;

  StudentAndMarkEntity({required this.user, this.mark});

  static StudentAndMarkEntity fromJson(Map<String, dynamic> json) {
    return StudentAndMarkEntity(
        user: UserEntity.fromJson(json, prefix: "user."),
        mark: MarkEntity.fromJson(json, prefix: 'mark.'));
  }
}
