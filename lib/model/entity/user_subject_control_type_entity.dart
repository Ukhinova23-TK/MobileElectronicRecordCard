class UserSubjectControlTypeEntity {
  int? id;
  int? teacherId;
  int? studentId;
  int? subjectId;
  int? controlTypeId;
  int? semester;
  int? hoursNumber;
  int? version;

  UserSubjectControlTypeEntity(
      {this.id,
      this.teacherId,
      this.studentId,
      this.subjectId,
      this.controlTypeId,
      this.semester,
      this.hoursNumber,
      this.version});

  static UserSubjectControlTypeEntity fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var teacherId = json['teacherId'];
    var studentId = json['studentId'];
    var subjectId = json['subjectId'];
    var controlTypeId = json['controlTypeId'];
    var semester = json['semester'];
    var hoursNumber = json['hoursNumber'];
    var version = json['version'];
    return UserSubjectControlTypeEntity(
        id: id,
        teacherId: teacherId,
        studentId: studentId,
        subjectId: subjectId,
        controlTypeId: controlTypeId,
        semester: semester,
        hoursNumber: hoursNumber,
        version: version);
  }

  static Map<String, dynamic> toJson(
      UserSubjectControlTypeEntity userSubjectControlType) {
    return {
      'id': userSubjectControlType.id,
      'teacherId': userSubjectControlType.teacherId,
      'studentId': userSubjectControlType.studentId,
      'subjectId': userSubjectControlType.subjectId,
      'controlTypeId': userSubjectControlType.controlTypeId,
      'semester': userSubjectControlType.semester,
      'hoursNumber': userSubjectControlType.hoursNumber,
      'version': userSubjectControlType.version
    };
  }

  static Map<String, dynamic> toCriteriaJson(String name, int id) {
    return {name: id};
  }

  static Map<String, dynamic> toTeacherCriteriaJson(int teacherId) {
    return toCriteriaJson('teacher.id', teacherId);
  }

  static Map<String, dynamic> toStudentCriteriaJson(int studentId) {
    return toCriteriaJson('student.id', studentId);
  }
}
