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
    final response = await EndPoint.http.get(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.groupUrl}'
            '${EndPoint.getByVersionUrl}$version'),
        headers: headers);
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => GroupEntity.fromJson(e))
        .toList();
  }
}
