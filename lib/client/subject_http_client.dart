import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';

abstract class SubjectHttpClient {
  Future<List<SubjectEntity>> getAll();
}
