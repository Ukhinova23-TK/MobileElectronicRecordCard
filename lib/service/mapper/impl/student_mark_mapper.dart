import 'package:mobile_electronic_record_card/model/entity/student_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';

import '../mapper.dart';

class StudentMarkMapper implements Mapper<StudentMarkEntity, Student_mark> {
  @override
  StudentMarkEntity toEntity(Student_mark model) {
    return StudentMarkEntity(
        id: model.id,
        markId: model.mark_id,
        userSubjectControlTypeId: model.user_subject_control_type_id,
        completionDate: model.completion_date,
        saved: model.saved,
        version: model.version);
  }

  @override
  Student_mark toModel(StudentMarkEntity entity) {
    return Student_mark(
        id: entity.id,
        completion_date: entity.completionDate,
        mark_id: entity.markId,
        user_subject_control_type_id: entity.userSubjectControlTypeId,
        saved: entity.saved,
        version: entity.version);
  }
}
