import 'dart:convert';

import 'package:mobile_electronic_record_card/client/control_type_http_client.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/control_type_repository_impl.dart';

class ControlTypeHttpClientImpl implements ControlTypeHttpClient {
  @override
  Future<List<ControlTypeEntity>> getAll() async {
    final version = await ControlTypeRepositoryImpl().getMaxVersion();
    final response = await EndPoint.http.get(Uri.parse(
        "${EndPoint.resourceUrl}${EndPoint.controlTypeUrl}"
            "${EndPoint.getByVersionUrl}$version"));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => ControlTypeEntity.fromJson(e))
        .toList();
  }
}
