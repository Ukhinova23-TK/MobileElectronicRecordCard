import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';

abstract class UserSubjectControlTypeHttpClient {
  Future<List<UserSubjectControlTypeEntity>> getAll();
}
