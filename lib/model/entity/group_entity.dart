class GroupEntity {
  int? id;
  String? name;
  String? fullName;
  DateTime? admissionDate;

  GroupEntity({
    this.id,
    this.name,
    this.fullName,
    this.admissionDate,
  });

  static GroupEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    var fullName = json['fullName'];
    var admissionDate = json['admissionDate'];
    return GroupEntity(id: id, name: name, fullName: fullName, admissionDate: admissionDate);
  }

  static Map<String, dynamic> toJson(GroupEntity group) {
    return {
      'id': group.id,
      'name': group.name,
      'fullName': group.fullName,
      'admissionDate': group.admissionDate,
    };
  }
}