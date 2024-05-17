import 'dart:convert';

import 'package:mobile_electronic_record_card/client/role_http_client.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/role_entity.dart';

class RoleHttpClientImpl implements RoleHttpClient {
  @override
  Future<List<RoleEntity>> getAll() async {
    final response = await EndPoint.http.get(Uri.parse('${EndPoint.resourceUrl}'
        '${EndPoint.roleUrl}'));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => RoleEntity.fromJson(e))
        .toList();
  }
}
