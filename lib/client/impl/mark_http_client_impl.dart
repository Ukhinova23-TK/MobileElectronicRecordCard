import 'dart:convert';

import 'package:mobile_electronic_record_card/client/mark_http_client.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_repository_impl.dart';

class MarkHttpClientImpl implements MarkHttpClient {
  @override
  Future<List<MarkEntity>> getAll() async {
    final version = await MarkRepositoryImpl().getMaxVersion();
    final response = await EndPoint.http
        .get(Uri.parse('${EndPoint.resourceUrl}${EndPoint.markUrl}'
        '${EndPoint.getByVersionUrl}$version'));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => MarkEntity.fromJson(e))
        .toList();
  }
}
