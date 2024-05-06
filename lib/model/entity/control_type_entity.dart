class ControlTypeEntity {
  int? id;
  String? name;
  String? title;
  int? version;

  ControlTypeEntity({this.id, this.name, this.title, this.version});

  static ControlTypeEntity fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var name = json['name'];
    var title = json['title'];
    var version = json['version'];
    return ControlTypeEntity(
        id: id, name: name, title: title, version: version);
  }

  static Map<String, dynamic> toJson(ControlTypeEntity controlType) {
    return {
      'id': controlType.id,
      'name': controlType.name,
      'title': controlType.title,
      'version': controlType.version
    };
  }
}
