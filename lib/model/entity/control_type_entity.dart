class ControlTypeEntity {
  int? id;
  String? name;
  String? title;

  ControlTypeEntity({
    this.id,
    this.name,
    this.title,
  });

  static ControlTypeEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    var title = json['title'];
    return ControlTypeEntity(id: id, name: name, title: title);
  }

  static Map<String, dynamic> toJson(ControlTypeEntity controlType) {
    return {
      'id': controlType.id,
      'name': controlType.name,
      'title': controlType.title,
    };
  }
}