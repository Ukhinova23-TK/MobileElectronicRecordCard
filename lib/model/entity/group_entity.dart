class GroupEntity {
  int? id;
  String? name;
  String? fullName;
  DateTime? admissionDate;
  int? version;

  GroupEntity(
      {this.id, this.name, this.fullName, this.admissionDate, this.version});

  static GroupEntity fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var name = json['name'];
    var fullName = json['fullName'];
    var admissionDate = json['admissionDate'];
    var version = json['version'];
    return GroupEntity(
        id: id,
        name: name,
        fullName: fullName,
        admissionDate: admissionDate,
        version: version);
  }

  static Map<String, dynamic> toJson(GroupEntity group) {
    return {
      'id': group.id,
      'name': group.name,
      'fullName': group.fullName,
      'admissionDate': group.admissionDate,
      'version': group.version
    };
  }
}
