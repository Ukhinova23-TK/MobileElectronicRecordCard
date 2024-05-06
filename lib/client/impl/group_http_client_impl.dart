import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/entity/group_entity.dart';
import '../group_http_client.dart';
import '../../constants/api_constants.dart';

class GroupHttpClientImpl implements GroupHttpClient {
  @override
  Future<List<GroupEntity>> getAll() async {
    final response = await http.get(Uri.parse(resourceUrl + groupUrl));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => GroupEntity.fromJson(e))
        .toList();
  }
}
