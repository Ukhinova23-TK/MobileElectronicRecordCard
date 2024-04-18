import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/client/impl/control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/page/group_page.dart';

import 'client/control_type_http_client.dart';
import 'page/subject_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ControlTypeController controller = ControlTypeController();
  controller.synchronization().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title = 'Record card';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: GroupPage(),
    );
  }
}