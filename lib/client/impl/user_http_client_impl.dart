import 'dart:convert';

import 'package:mobile_electronic_record_card/client/user_http_client.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_repository_impl.dart';

class UserHttpClientImpl implements UserHttpClient {
  @override
  Future<List<UserEntity>> getAll() async {
    final version = await UserRepositoryImpl().getMaxVersion();
    final Map<String, dynamic> body = {};
    final response = await EndPoint.http.post(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.userUrl}'
            '${EndPoint.getByVersionUrl}$version${EndPoint.userAndCriteriaUrl}'),
        headers: headers,
        body: jsonEncode(body));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => UserEntity.fromJson(e))
        .toList();
  }

  @override
  Future<UserEntity> getByLogin(String login) async {
    final response = await EndPoint.http.get(Uri.parse('${EndPoint.resourceUrl}'
        '${EndPoint.userUrl}${EndPoint.userByLoginUrl}/$login'));
    return UserEntity.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<Map<String, dynamic>> authenticate(Map<String, dynamic> cred) async {
    final response = await EndPoint.http.post(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.userUrl}'
            '${EndPoint.userAuthenticateUrl}'),
        headers: headers,
        body: jsonEncode(cred));
    return json.decode(utf8.decode(response.bodyBytes));
  }

  @override
  Future<Map<String, dynamic>> refreshToken(
      Map<String, dynamic> refreshToken) async {
    final response =
        await EndPoint.http.post(
            Uri.parse('${EndPoint.resourceUrl}${EndPoint.userUrl}'
                '${EndPoint.userRefreshTokenUrl}'),
            headers: headers,
            body: jsonEncode(refreshToken));
    return json.decode(utf8.decode(response.bodyBytes));
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    final response =
        await EndPoint.http.post(
            Uri.parse('${EndPoint.resourceUrl}${EndPoint.userUrl}'
                '${EndPoint.userLogoutUrl}'),
            headers: headers);
    return json.decode(utf8.decode(response.bodyBytes));
  }
}
