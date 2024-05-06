class RoleEntity {
  int? id;
  String? name;
  int? version;

  RoleEntity({
    this.id,
    this.name,
    this.version
  });

  static RoleEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    var version = json['version'];
    return RoleEntity(id: id, name: name, version: version);
  }

  static Map<String, dynamic> toJson(RoleEntity role) {
    return {
      'id': role.id,
      'name': role.name,
      'version': role.version
    };
  }
}