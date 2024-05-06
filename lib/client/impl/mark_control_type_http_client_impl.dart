import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/api_constants.dart';
import '../../model/entity/mark_control_type_entity.dart';
import '../mark_control_type_http_client.dart';

class MarkControlTypeHttpClientImpl implements MarkControlTypeHttpClient {
  @override
  Future<List<MarkControlTypeEntity>> getAll() async {
    final response = await http
        .get(Uri.parse(resourceUrl + controlTypeUrl + controlTypeWithMarksUrl));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => MarkControlTypeEntity.fromJsonWithMarks(e).toList())
        .reduce((value, element) {
      value.addAll(element);
      return value;
    }).toList();
  }
}
