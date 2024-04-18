class RoleEntity {
  int? id;
  String? name;

  RoleEntity({
    this.id,
    this.name
  });

  static RoleEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    return RoleEntity(id: id, name: name);
  }

  static Map<String, dynamic> toJson(RoleEntity role) {
    return {
      'id': role.id,
      'name': role.name,
    };
  }
}