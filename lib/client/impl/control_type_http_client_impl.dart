import 'dart:convert';

import 'package:mobile_electronic_record_card/client/control_type_http_client.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';

class ControlTypeHttpClientImpl implements ControlTypeHttpClient {
  @override
  Future<List<ControlTypeEntity>> getAll() async {
    final response = await EndPoint.http.get(
        Uri.parse("${EndPoint.resourceUrl}${EndPoint.controlTypeUrl}"),
        headers: headers);
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => ControlTypeEntity.fromJson(e))
        .toList();
  }
}
