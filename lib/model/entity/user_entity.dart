class UserEntity {
  int? id;
  String? login;
  String? lastName;
  String? firstName;
  String? middleName;
  int? groupId;
  List<dynamic>? roles;

  UserEntity({
    this.id,
    this.login,
    this.lastName,
    this.firstName,
    this.middleName,
    this.groupId
  });

  UserEntity.withRoles({
    this.id,
    this.login,
    this.lastName,
    this.firstName,
    this.middleName,
    this.groupId,
    this.roles
  });

  static UserEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var login = json['login'];
    var lastName = json['lastName'];
    var firstName = json['firstName'];
    var middleName = json['middleName'];
    var groupId = json['groupId'];
    var roles = json['roles'];
    return UserEntity.withRoles(
        id: id,
        login: login,
        lastName: lastName,
        firstName: firstName,
        middleName: middleName,
        groupId: groupId,
        roles: roles
    );
  }

  static Map<String, dynamic> toJson(UserEntity user) {
    return {
      'id': user.id,
      'login': user.login,
      'lastName': user.lastName,
      'firstName': user.firstName,
      'middleName': user.middleName,
      'groupId': user.groupId,
      'roles': user.roles
    };
  }


}