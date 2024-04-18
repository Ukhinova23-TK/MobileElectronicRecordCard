import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/api_constants.dart';
import '../../model/entity/subject_entity.dart';
import '../subject_http_client.dart';

class SubjectHttpClientImpl implements SubjectHttpClient {
  @override
  Future<List<SubjectEntity>> getAll() async {
    final response = await http.get(
        Uri.parse('$resourceUrl$subjectUrl'));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) =>
        SubjectEntity.fromJson(e)).toList();
  }

  @override
  Future<SubjectEntity> getById(int id) async {
    final response = await http.get(
        Uri.parse('$resourceUrl$subjectUrl/$id'));
    return SubjectEntity
        .fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

}