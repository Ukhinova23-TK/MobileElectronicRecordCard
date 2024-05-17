import 'dart:convert';

import 'package:mobile_electronic_record_card/client/mark_control_type_http_client.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_control_type_entity.dart';

class MarkControlTypeHttpClientImpl implements MarkControlTypeHttpClient {
  @override
  Future<List<MarkControlTypeEntity>> getAll() async {
    final response = await EndPoint.http.get(Uri.parse(EndPoint.resourceUrl +
        EndPoint.controlTypeUrl +
        EndPoint.controlTypeWithMarksUrl));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => MarkControlTypeEntity.fromJsonWithMarks(e).toList())
        .reduce((value, element) {
      value.addAll(element);
      return value;
    }).toList();
  }
}
