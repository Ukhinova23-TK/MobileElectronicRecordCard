import 'dart:convert';

import 'package:mobile_electronic_record_card/client/mark_http_client.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';

class MarkHttpClientImpl implements MarkHttpClient {
  @override
  Future<List<MarkEntity>> getAll() async {
    final response = await EndPoint.http.get(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.markUrl}'),
        headers: headers);
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => MarkEntity.fromJson(e))
        .toList();
  }
}
