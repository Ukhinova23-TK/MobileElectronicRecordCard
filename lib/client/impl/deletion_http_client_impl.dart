import 'dart:convert';

import 'package:mobile_electronic_record_card/client/deletion_http_client.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/deletion_entity.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';

class DeletionHttpClientImpl implements DeletionHttpClient {
  @override
  Future<List<DeletionEntity>> getAll() async {
    final sharedLocator = getIt.get<SharedPreferenceHelper>();
    final version = sharedLocator.getDeletionVersion() ?? 0;
    final response = await EndPoint.http.get(
        Uri.parse('${EndPoint.resourceUrl}${EndPoint.deletionUrl}'
            '${EndPoint.getByVersionUrl}$version'),
        headers: headers);
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => DeletionEntity.fromJson(e))
        .toList();
  }
}
