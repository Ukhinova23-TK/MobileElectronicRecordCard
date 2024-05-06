class MarkEntity {
  int? id;
  String? name;
  String? title;
  int? value;
  int? version;

  MarkEntity({this.id, this.name, this.title, this.value, this.version});

  static MarkEntity fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var name = json['name'];
    var title = json['title'];
    var value = json['value'];
    var version = json['version'];
    return MarkEntity(
        id: id, name: name, title: title, value: value, version: version);
  }

  static Map<String, dynamic> toJson(MarkEntity mark) {
    return {
      'id': mark.id,
      'name': mark.name,
      'title': mark.title,
      'admission_date': mark.value,
      'version': mark.version
    };
  }
}
