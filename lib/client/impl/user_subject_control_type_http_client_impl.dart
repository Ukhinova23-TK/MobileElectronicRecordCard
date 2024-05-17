import 'dart:convert';

import 'package:mobile_electronic_record_card/client/user_subject_control_type_http_client.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';

class UserSubjectControlTypeHttpClientImpl
    implements UserSubjectControlTypeHttpClient {
  @override
  Future<List<UserSubjectControlTypeEntity>> getAll() async {
    final version = await UserSubjectControlTypeRepositoryImpl().getMaxVersion();
    final response = await EndPoint.http.get(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.usctUrl}'
            '${EndPoint.getByVersionUrl}$version'),
        headers: headers);
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => UserSubjectControlTypeEntity.fromJson(e))
        .toList();
  }
}
