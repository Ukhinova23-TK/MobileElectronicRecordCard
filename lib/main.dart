import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
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
import 'package:mobile_electronic_record_card/provider/user_subject_control_type_provider.dart';
import 'package:mobile_electronic_record_card/repository/impl/control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/group_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/student_mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/subject_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:provider/provider.dart';

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

  Future<void> delete() async {
    await SubjectRepositoryImpl().deleteAll();
    await ControlTypeRepositoryImpl().deleteAll();
    await MarkRepositoryImpl().deleteAll();
    await MarkControlTypeRepositoryImpl().deleteAll();
    await StudentMarkRepositoryImpl().deleteAll();
    await GroupRepositoryImpl().deleteAll();
    await UserRepositoryImpl().deleteAll();
    await UserSubjectControlTypeRepositoryImpl().deleteAll();
    Log.d('Delete successful', tag: 'main');
  }

  @override
  Widget build(BuildContext context) {
    //secureLocator.removeToken();
    //sharedLocator.deleteAll();
    //Future.microtask(() async => await delete());
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
        ChangeNotifierProvider(create: (_) => StudentMarkProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: greatMarkColor),
          useMaterial3: true,
        ),
        home: token != null
            ? (sharedLocator.getGroupId() != null
                ? const RecordCardPage()
                : SubjectPage(bottomNavBar: sharedLocator.getRolesCount() == 2))
            : const AuthorizationPage(),
      ),
    );
  }
}
