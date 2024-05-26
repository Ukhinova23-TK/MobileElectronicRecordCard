import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile_electronic_record_card/controller/user_controller.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/main.dart';
import 'package:mobile_electronic_record_card/model/enumeration/exception_name.dart';
import 'package:mobile_electronic_record_card/page/synchronization_function.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';

class AuthInterceptor implements InterceptorContract {
  final secureStorageLocator = getIt.get<SecureStorageHelper>();

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    var token = await secureStorageLocator.readToken();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    if (response.statusCode == 200 || response.statusCode == 204) {
      Log.i('Запрос ${response.request?.url.toString()} выполнен успешно',
          tag: response.reasonPhrase.toString());
      if (response.request?.url.toString() == ExceptionName.refresh) {
        await response.request?.send();
      }
    }
    if (response.statusCode == 401) {
      Log.w('Ошибка авторизации ${response.request?.url.toString()}',
          tag: response.reasonPhrase.toString());
      if (response.request?.url.toString() == ExceptionName.refresh ||
          response.request?.url.toString() == ExceptionName.authenticate) {
        logout(globalNavigatorKey.currentContext!);
      } else {
        UserController().refreshToken();
      }
    }
    if (response.statusCode == 403) {
      Log.w('Ошибка доступа ${response.request?.url.toString()}',
          tag: response.reasonPhrase.toString());
    }
    if (response.statusCode == 409) {
      Log.w('Ошибка версионности ${response.request?.url.toString()}',
          tag: response.reasonPhrase.toString());
    }
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => true;
}
