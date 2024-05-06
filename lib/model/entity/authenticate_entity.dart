class AuthenticateEntity {
  String? login;
  String? password;
  String? token;

  AuthenticateEntity(this.login, this.password);

  Map<String, dynamic> toJson() => {'login': login, "password": password};

  AuthenticateEntity.fromJson(Map<String, dynamic> json)
      : token = json['token'];
}
