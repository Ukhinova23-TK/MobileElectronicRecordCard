import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile_electronic_record_card/client/interceptor/auth_interceptor.dart';

class EndPoint {
  static const String resourceUrl = 'http://192.168.3.67:8080/';
  static const String getByVersionUrl = '/version/';

  static const String controlTypeUrl = 'api/control-types';
  static const String controlTypeWithMarksUrl = '/with-marks';

  static const String groupUrl = 'api/groups';
  static const String groupAndCriteriaUrl = '/filter';

  static const String markUrl = 'api/marks';

  static const String roleUrl = 'api/roles';

  static const String subjectUrl = 'api/subjects';
  static const String subjectAndCriteriaUrl = '/filter';

  static const String userUrl = 'api/users';
  static const String userAndCriteriaUrl = '/filter';
  static const String userByLoginUrl = '/login';
  static const String userAuthenticateUrl = '/authenticate';
  static const String userRefreshTokenUrl = '/refresh';
  static const String userLogoutUrl = '/logout';
  static const String userChangePassword = '/change-password';

  static const String usctUrl = 'api/user-subject-control-types';
  static const String usctAndCriteriaUrl = '/filter';

  static const String studentMarkUrl = 'api/student-marks';
  static const String studentMarkAllUrl = '/all';
  static const String studentMarAndCriteriaUrl = '/filter';

  static const String deletionUrl = 'api/deletions';
  static const String deletionAndCriteriaUrl = '/filter';

  static final http = InterceptedHttp.build(interceptors: [AuthInterceptor()]);
}
