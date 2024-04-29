import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

import '../../constants/api_constants.dart';
import '../../model/entity/role_entity.dart';
import '../user_http_client.dart';

class UserHttpClientImpl implements UserHttpClient {
  @override
  Future<List<RoleEntity>> getUserRoles(int id) async {
    final response = await http.get(
        Uri.parse('$resourceUrl$userUrl/$id$userRoleUrl'));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) =>
        RoleEntity.fromJson(e)).toList();
  }

  @override
  Future<List<UserEntity>> getAll() async {
    final response = await http.get(
        Uri.parse('$resourceUrl$userUrl'));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) =>
        UserEntity.fromJson(e)).toList();
  }

  @override
  Future<UserEntity> getByLogin(String login) async {
    final response = await http.get(
        Uri.parse('$resourceUrl$userUrl/$login'));
    return UserEntity.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<Map<String, dynamic>> authenticate(Map<String, dynamic> cred) async {
    final response = await http.post(
      Uri.parse('$resourceUrl$userUrl$userAuthenticateUrl'),
      headers: headers,
      body: jsonEncode(cred)
    );
    return json.decode(utf8.decode(response.bodyBytes));
  }
  
}