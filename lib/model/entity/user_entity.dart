class UserEntity {
  int? id;
  String? login;
  String? lastName;
  String? firstName;
  String? middleName;
  int? groupId;
  List<dynamic>? roles;
  int? version;

  UserEntity(
      {this.id,
      this.login,
      this.lastName,
      this.firstName,
      this.middleName,
      this.groupId,
      this.version});

  UserEntity.withRoles(
      {this.id,
      this.login,
      this.lastName,
      this.firstName,
      this.middleName,
      this.groupId,
      this.roles,
      this.version});

  static UserEntity fromJson(Map<String, dynamic> json, {String prefix = ""}) {
    var id = json['${prefix}id'];
    var login = json['${prefix}login'];
    var lastName = json['${prefix}lastName'];
    var firstName = json['${prefix}firstName'];
    var middleName = json['${prefix}middleName'];
    var groupId = json['${prefix}groupId'];
    var roles = json['${prefix}roles'];
    var version = json['${prefix}version'];
    return UserEntity.withRoles(
        id: id,
        login: login,
        lastName: lastName,
        firstName: firstName,
        middleName: middleName,
        groupId: groupId,
        roles: roles,
        version: version);
  }

  static Map<String, dynamic> toJson(UserEntity user) {
    return {
      'id': user.id,
      'login': user.login,
      'lastName': user.lastName,
      'firstName': user.firstName,
      'middleName': user.middleName,
      'groupId': user.groupId,
      'roles': user.roles,
      'version': user.version
    };
  }

  static Map<String, dynamic> toStudentCriteriaJson(int id) {
    return {'teacherUserSubjectControlTypes.student.id': id};
  }

  static Map<String, dynamic> toTeacherCriteriaJson(int id) {
    return {'studentUserSubjectControlTypes.teacher.id': id};
  }
}
