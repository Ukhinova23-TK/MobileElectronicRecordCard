import 'package:mobile_electronic_record_card/data/endpoint/endpoint.dart';

class ExceptionName {
  static const String refresh = '${EndPoint.resourceUrl}${EndPoint.userUrl}'
      '${EndPoint.userRefreshTokenUrl}';
  static const String authenticate = '${EndPoint.resourceUrl}${EndPoint.userUrl}'
      '${EndPoint.userAuthenticateUrl}';
  static const String logout = '${EndPoint.resourceUrl}${EndPoint.userUrl}'
      '${EndPoint.userLogoutUrl}';
}