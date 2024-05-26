class AuthenticateEntity {
  String? login;
  String? password;
  String? token;
  String? refreshToken;

  AuthenticateEntity(this.login, this.password);

  Map<String, dynamic> toJson() => {'login': login, "password": password};

  static Map<String, dynamic> toRefreshJson(String refreshToken) =>
      {'refreshToken': refreshToken};

  static Map<String, dynamic> toChangePassword(
          String oldPassword, String newPassword) =>
      {'oldPassword': oldPassword, 'newPassword': newPassword};

  AuthenticateEntity.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        refreshToken = json['refreshToken'];
}
