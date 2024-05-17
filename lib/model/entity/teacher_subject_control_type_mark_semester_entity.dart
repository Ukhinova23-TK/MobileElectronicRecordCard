import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

class TeacherSubjectControlTypeMarkSemesterEntity {
  UserEntity teacher;
  MarkEntity? mark;
  ControlTypeEntity controlType;
  SubjectEntity subject;
  int semester;

  TeacherSubjectControlTypeMarkSemesterEntity(
      {required this.teacher,
      required this.subject,
      required this.controlType,
      required this.semester,
      this.mark});

  static TeacherSubjectControlTypeMarkSemesterEntity fromJson(
      Map<String, dynamic> json) {
    return TeacherSubjectControlTypeMarkSemesterEntity(
        teacher: UserEntity.fromJson(json, prefix: "user."),
        subject: SubjectEntity.fromJson(json, prefix: 'subject.'),
        controlType: ControlTypeEntity.fromJson(json, prefix: 'control_type.'),
        mark: MarkEntity.fromJson(json, prefix: 'mark.'),
        semester: json['semester']);
  }
}
