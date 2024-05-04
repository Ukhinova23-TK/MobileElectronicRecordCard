import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/page/authorization_page.dart';
import 'package:mobile_electronic_record_card/page/teacher/subject_page.dart';
import 'package:mobile_electronic_record_card/provider/subject_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //runApp(const MyApp());
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => SubjectProvider(),
          )
        ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: greatMarkColor),
        useMaterial3: true,
      ),
      home: const SubjectPage(),
    );
  }
}