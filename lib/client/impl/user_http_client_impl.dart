import 'dart:convert';

import 'package:http/http.dart' as http;

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

}