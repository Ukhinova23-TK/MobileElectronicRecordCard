class UserEntity {
  int? id;
  String? login;
  String? lastName;
  String? firstName;
  String? middleName;
  int? groupId;

  UserEntity({
    this.id,
    this.login,
    this.lastName,
    this.firstName,
    this.middleName,
    this.groupId
  });

  static UserEntity fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var login = json['login'];
    var lastName = json['last_name'];
    var firstName = json['first_name'];
    var middleName = json['middle_name'];
    var groupId = json['group_id'];
    return UserEntity(
        id: id,
        login: login,
        lastName: lastName,
        firstName: firstName,
        middleName: middleName,
        groupId: groupId
    );
  }

  static Map<String, dynamic> toJson(UserEntity user) {
    return {
      'id': user.id,
      'login': user.login,
      'last_name': user.lastName,
      'first_name': user.firstName,
      'middle_name': user.middleName,
      'group_id': user.groupId,
    };
  }
}