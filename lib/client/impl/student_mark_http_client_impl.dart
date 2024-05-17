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
    final response = await EndPoint.http.get(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.studentMarkUrl}'
            '${EndPoint.getByVersionUrl}$version'),
        headers: headers);
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => StudentMarkEntity.fromJson(e))
        .toList();
  }

  @override
  Future<void> post(StudentMarkEntity studentMark) async {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<void> update(StudentMarkEntity studentMark) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
