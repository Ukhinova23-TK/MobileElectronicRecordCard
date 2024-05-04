import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';

abstract class UserSubjectControlTypeHttpClient {
  Future<List<UserSubjectControlTypeEntity>> getAll();

  Future<List<UserSubjectControlTypeEntity>> getByCriteria(
      UserSubjectControlTypeEntity userSubjectControlTypeEntity);

  Future<List<UserSubjectControlTypeEntity>> getByCriteriaV2(
      Map<String, dynamic> criteria);
}
