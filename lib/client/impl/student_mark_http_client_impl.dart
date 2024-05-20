import 'dart:convert';

import 'package:mobile_electronic_record_card/client/student_mark_http_client.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/student_mark_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/student_mark_repository_impl.dart';

class StudentMarkHttpClientImpl implements StudentMarkHttpClient {
  @override
  Future<List<StudentMarkEntity>> getAll() async {
    final version = await StudentMarkRepositoryImpl().getMaxVersion();
    final Map<String, dynamic> body = {};
    final response = await EndPoint.http.post(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.studentMarkUrl}'
            '${EndPoint.getByVersionUrl}$version'
            '${EndPoint.studentMarAndCriteriaUrl}'),
        headers: headers,
        body: jsonEncode(body));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => StudentMarkEntity.fromJson(e))
        .toList();
  }

  @override
  Future<List<StudentMarkEntity>> push(
      List<StudentMarkEntity> studentMarks) async {
    final response = await EndPoint.http.post(
        Uri.parse('${EndPoint.resourceUrl}'
            '${EndPoint.studentMarkUrl}${EndPoint.studentMarkAllUrl}'),
        headers: headers,
        body: jsonEncode(
            studentMarks.map((e) => StudentMarkEntity.toJson(e)).toList()));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => StudentMarkEntity.fromJson(e))
        .toList();
  }
}
