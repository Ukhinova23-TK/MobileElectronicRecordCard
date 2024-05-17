class SubjectEntity {
  int? id;
  String? name;
  int? version;

  SubjectEntity({this.id, this.name, this.version});

  static SubjectEntity fromJson(Map<String, dynamic> json,
      {String prefix = ""}) {
    var id = json['${prefix}id'];
    var name = json['${prefix}name'];
    var version = json['${prefix}version'];
    return SubjectEntity(id: id, name: name, version: version);
  }

  static Map<String, dynamic> toJson(SubjectEntity subject) {
    return {'id': subject.id, 'name': subject.name, 'version': subject.version};
  }
}
