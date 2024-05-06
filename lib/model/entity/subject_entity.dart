class SubjectEntity {
  int? id;
  String? name;
  int? version;

  SubjectEntity({
    this.id,
    this.name,
    this.version
  });

  static SubjectEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    var version = json['version'];
    return SubjectEntity(id: id, name: name, version: version);
  }

  static Map<String, dynamic> toJson(SubjectEntity subject) {
    return {
      'id': subject.id,
      'name': subject.name,
      'version': subject.version
    };
  }
}