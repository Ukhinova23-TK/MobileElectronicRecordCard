import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_electronic_record_card/client/user_subject_control_type_http_client.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';

class UserSubjectControlTypeHttpClientImpl
    implements UserSubjectControlTypeHttpClient {
  @override
  Future<List<UserSubjectControlTypeEntity>> getAll(
      Map<String, dynamic> criteria) async {
    final response = await http.post(
        Uri.parse('$resourceUrl$usctUrl$usctAndCriteriaUrl'),
        headers: headers,
        body: jsonEncode(criteria));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => UserSubjectControlTypeEntity.fromJson(e))
        .toList();
  }
}
