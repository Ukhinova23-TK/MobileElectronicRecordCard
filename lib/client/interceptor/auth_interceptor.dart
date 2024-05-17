import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';

class AuthInterceptor implements InterceptorContract {
  final secureStorageLocator = getIt.get<SecureStorageHelper>();

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    var token = await secureStorageLocator.readToken();
    if(token != null) {
      request.headers['Authorization'] =
      'Bearer $token';
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    if(response.statusCode == 403) {
      Log.e(response.reasonPhrase.toString(), tag: 'Ошибка доступа');
    }
    if(response.statusCode == 409) {
      Log.e(response.reasonPhrase.toString(), tag: 'Ошибка версионности');
    }
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => true;
}
