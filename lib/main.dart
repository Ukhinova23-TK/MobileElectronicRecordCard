import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/page/authorization_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: greatMarkColor),
        useMaterial3: true,
      ),
      home: const AuthorizationPage(),
    );
  }
}