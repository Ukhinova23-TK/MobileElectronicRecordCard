import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class UserSubjectControlTypeMapper implements
    Mapper<UserSubjectControlTypeEntity, User_subject_control_type> {
  @override
  UserSubjectControlTypeEntity toEntity(User_subject_control_type model) {
    return UserSubjectControlTypeEntity(
      id: model.id,
      teacherId: model.teacher_id,
      studentId: model.student_id,
      subjectId: model.subject_id,
      controlTypeId: model.control_type_id,
      semester: model.semester,
      hoursNumber: model.hours_number
    );
  }

  @override
  User_subject_control_type toModel(UserSubjectControlTypeEntity entity) {
    return User_subject_control_type(
        id: entity.id,
        teacher_id: entity.teacherId,
        student_id: entity.studentId,
        subject_id: entity.subjectId,
        control_type_id: entity.controlTypeId,
        semester: entity.semester,
        hours_number: entity.hoursNumber
    );
  }

}