class SubjectEntity {
  int? id;
  String? name;

  SubjectEntity({
    this.id,
    this.name
  });

  static SubjectEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    return SubjectEntity(id: id, name: name);
  }

  static Map<String, dynamic> toJson(SubjectEntity subject) {
    return {
      'id': subject.id,
      'name': subject.name,
    };
  }
}