import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_electronic_record_card/client/role_http_client.dart';
import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';

import '../../constants/api_constants.dart';

class RoleHttpClientImpl implements RoleHttpClient {
  @override
  Future<List<RoleEntity>> getAll() async {
    final response = await http.get(
        Uri.parse('$resourceUrl$roleUrl'));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) =>
        RoleEntity.fromJson(e)).toList();
  }

}