class ControlTypeEntity {
  int? id;
  String? name;
  String? title;
  int? version;

  ControlTypeEntity({this.id, this.name, this.title, this.version});

  static ControlTypeEntity fromJson(Map<String, dynamic> json,
      {String prefix = ""}) {
    var id = json['${prefix}id'];
    var name = json['${prefix}name'];
    var title = json['${prefix}title'];
    var version = json['${prefix}version'];
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
