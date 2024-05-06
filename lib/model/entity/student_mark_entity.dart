class StudentMarkEntity {
  int? id;
  int? markId;
  int? userSubjectControlTypeId;
  DateTime? completionDate;
  int? version;

  StudentMarkEntity(
      {this.id,
      this.markId,
      this.userSubjectControlTypeId,
      this.completionDate,
      this.version});

  static StudentMarkEntity fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var markId = json['mark_id'];
    var userSubjectControlTypeId = json['user_subject_control_type_id'];
    var completionDate = json['completion_date'];
    var version = json['version'];
    return StudentMarkEntity(
        id: id,
        markId: markId,
        userSubjectControlTypeId: userSubjectControlTypeId,
        completionDate: completionDate,
        version: version);
  }

  static Map<String, dynamic> toJson(StudentMarkEntity studentMark) {
    return {
      'id': studentMark.id,
      'mark_id': studentMark.markId,
      'user_subject_control_type_id': studentMark.userSubjectControlTypeId,
      'completion_date': studentMark.completionDate,
      'version': studentMark.version
    };
  }
}
