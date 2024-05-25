import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/page/authorization_page.dart';
import 'package:mobile_electronic_record_card/page/student/record_card_page.dart';
import 'package:mobile_electronic_record_card/page/teacher/subject_page.dart';
import 'package:mobile_electronic_record_card/provider/control_type_provider.dart';
import 'package:mobile_electronic_record_card/provider/group_provider.dart';
import 'package:mobile_electronic_record_card/provider/mark_provider.dart';
import 'package:mobile_electronic_record_card/provider/student_mark_provider.dart';
import 'package:mobile_electronic_record_card/provider/subject_provider.dart';
import 'package:mobile_electronic_record_card/provider/user_provider.dart';
import 'package:mobile_electronic_record_card/provider/user_subject_control_type_provider.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:provider/provider.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  final secureLocator = getIt.get<SecureStorageHelper>();
  final sharedLocator = getIt.get<SharedPreferenceHelper>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => await getToken());
  }

  Future<void> getToken() async {
    String? s = await secureLocator.readToken();
    setState(() {
      token = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*secureLocator.removeToken();
    sharedLocator.deleteAll();*/
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SubjectProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MarkProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GroupProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ControlTypeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserSubjectControlTypeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => StudentMarkProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        navigatorKey: globalNavigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: greatMarkColor),
          useMaterial3: true,
        ),
        home: token != null
            ? (sharedLocator.getGroupId() != null
                ? const RecordCardPage()
                : const SubjectPage())
            : const AuthorizationPage(),
      ),
    );
  }
}
