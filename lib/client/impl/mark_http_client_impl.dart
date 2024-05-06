import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/api_constants.dart';
import '../../model/entity/mark_entity.dart';
import '../mark_http_client.dart';

class MarkHttpClientImpl implements MarkHttpClient {
  @override
  Future<List<MarkEntity>> getAll() async {
    final response = await http.get(Uri.parse(resourceUrl + markUrl));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => MarkEntity.fromJson(e))
        .toList();
  }
}
