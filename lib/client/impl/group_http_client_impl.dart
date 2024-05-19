import 'dart:convert';

import 'package:mobile_electronic_record_card/client/group_http_client.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/group_repository_impl.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';

class GroupHttpClientImpl implements GroupHttpClient {
  @override
  Future<List<GroupEntity>> getAll() async {
    final version = await GroupRepositoryImpl().getMaxVersion();
    final Map<String, dynamic> body = {};
    final response = await EndPoint.http.post(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.groupUrl}'
            '${EndPoint.getByVersionUrl}$version'
            '${EndPoint.groupAndCriteriaUrl}'),
        headers: headers,
        body: jsonEncode(body));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => GroupEntity.fromJson(e))
        .toList();
  }
}
