class StudentMarkEntity {
  int? id;
  int? markId;
  int? userSubjectControlTypeId;
  DateTime? completionDate;
  bool? saved;
  int? version;

  StudentMarkEntity(
      {this.id,
      this.markId,
      this.userSubjectControlTypeId,
      this.completionDate,
      this.version,
      this.saved = false});

  static StudentMarkEntity fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var markId = json['markId'];
    var userSubjectControlTypeId = json['userSubjectControlTypeId'];
    var completionDate = int.tryParse(json['completionDate'].toString()) != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.tryParse(json['completionDate'].toString())!)
        : DateTime.tryParse(json['completionDate'].toString());
    var version = json['version'];
    var saved = (json['saved'] == 1 ? true : false);
    return StudentMarkEntity(
        id: id,
        markId: markId,
        userSubjectControlTypeId: userSubjectControlTypeId,
        completionDate: completionDate,
        saved: saved,
        version: version);
  }

  static Map<String, dynamic> toJson(StudentMarkEntity studentMark) {
    return {
      'id': studentMark.id,
      'markId': studentMark.markId,
      'userSubjectControlTypeId': studentMark.userSubjectControlTypeId,
      'completionDate': studentMark.completionDate.toString().split(' ').first,
      'saved': studentMark.saved,
      'version': studentMark.version
    };
  }
}
