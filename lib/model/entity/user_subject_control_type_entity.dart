class UserSubjectControlTypeEntity {
  int? id;
  int? teacherId;
  int? studentId;
  int? subjectId;
  int? controlTypeId;
  int? semester;
  int? hoursNumber;

  UserSubjectControlTypeEntity({
    this.id,
    this.teacherId,
    this.studentId,
    this.subjectId,
    this.controlTypeId,
    this.semester,
    this.hoursNumber
  });

  static UserSubjectControlTypeEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var teacherId = json['teacher_id'];
    var studentId = json['student_id'];
    var subjectId = json['subject_id'];
    var controlTypeId = json['control_type_id'];
    var semester = json['semester'];
    var hoursNumber = json['hours_number'];
    return UserSubjectControlTypeEntity(
        id: id,
        teacherId: teacherId,
        studentId: studentId,
        subjectId: subjectId,
        controlTypeId: controlTypeId,
        semester: semester,
        hoursNumber: hoursNumber
    );
  }

  static Map<String, dynamic> toJson(UserSubjectControlTypeEntity userSubjectControlType) {
    return {
      'id': userSubjectControlType.id,
      'teacher_id': userSubjectControlType.teacherId,
      'student_id': userSubjectControlType.studentId,
      'subject_id': userSubjectControlType.subjectId,
      'control_type_id': userSubjectControlType.controlTypeId,
      'semester': userSubjectControlType.semester,
      'hours_number': userSubjectControlType.hoursNumber,
    };
  }
}