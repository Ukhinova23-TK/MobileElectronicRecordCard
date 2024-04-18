class MarkEntity {
  int? id;
  String? name;
  String? title;
  int? value;

  MarkEntity({
    this.id,
    this.name,
    this.title,
    this.value
  });

  static MarkEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    var title = json['title'];
    var value = json['value'];
    return MarkEntity(id: id, name: name, title: title, value: value);
  }

  static Map<String, dynamic> toJson(MarkEntity mark) {
    return {
      'id': mark.id,
      'name': mark.name,
      'title': mark.title,
      'admission_date': mark.value,
    };
  }
}