import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/group_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/role_controller.dart';
import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/page/authorization_page.dart';
import 'package:mobile_electronic_record_card/page/student/record_card_page.dart';
import 'package:mobile_electronic_record_card/page/teacher/student_mark_page.dart';
import 'package:mobile_electronic_record_card/repository/impl/control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/group_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/subject_repository_impl.dart';

import 'controller/control_type_controller.dart';
import 'controller/user_controller.dart';
import 'page/teacher/subject_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*ControlTypeRepositoryImpl().deleteAll().then((value) =>
  {
    MarkRepositoryImpl().deleteAll().then((value) =>
    {
      MarkControlTypeRepositoryImpl().deleteAll().then((value) =>
      {
        runApp(const MyApp())
      })
    })
  });*/

  /*ControlTypeController controller = ControlTypeController();
  controller.synchronization().then((_) => runApp(const MyApp()));*/

  /*UserController controller = UserController();
  controller.synchronization().then((_) => runApp(const MyApp()));*/

  /*RoleController controller = RoleController();
  controller.synchronization().then((_) => runApp(const MyApp()));*/

  runApp(const MyApp());

  /*GroupRepositoryImpl().deleteAll().then((value) =>
  {
    GroupController().synchronization().then((value) =>
    {
      runApp(const MyApp())
    })
  });*/

  /*SubjectController controller = SubjectController();
  controller.synchronization().then((_) => runApp(const MyApp()));*/

  //SubjectRepositoryImpl().deleteAll().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
        useMaterial3: true,
      ),
      home: const SubjectPage(),
    );
  }
}