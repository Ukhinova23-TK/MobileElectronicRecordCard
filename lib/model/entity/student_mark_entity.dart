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
    var markId = json['markId'];
    var userSubjectControlTypeId = json['userSubjectControlTypeId'];
    var completionDate = json['completionDate'].runtimeType == String
        ? DateTime.parse(json['completionDate'])
        : DateTime.fromMicrosecondsSinceEpoch(json['completionDate']);
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
      'markId': studentMark.markId,
      'userSubjectControlTypeId': studentMark.userSubjectControlTypeId,
      'completionDate': studentMark.completionDate,
      'version': studentMark.version
    };
  }
}
