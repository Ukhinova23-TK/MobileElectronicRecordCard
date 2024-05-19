import 'dart:convert';

import 'package:mobile_electronic_record_card/client/subject_http_client.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/subject_repository_impl.dart';

class SubjectHttpClientImpl implements SubjectHttpClient {
  @override
  Future<List<SubjectEntity>> getAll() async {
    final version = await SubjectRepositoryImpl().getMaxVersion();
    final Map<String, dynamic> body = {};
    final response = await EndPoint.http.post(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.subjectUrl}'
            '${EndPoint.getByVersionUrl}$version${EndPoint.subjectAndCriteriaUrl}'),
        headers: headers,
        body: jsonEncode(body));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => SubjectEntity.fromJson(e))
        .toList();
  }
}
