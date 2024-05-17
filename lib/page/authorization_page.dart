import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/group_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_controller.dart';
import 'package:mobile_electronic_record_card/controller/role_controller.dart';
import 'package:mobile_electronic_record_card/controller/student_mark_controller.dart';
import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/controller/user_controller.dart';
import 'package:mobile_electronic_record_card/controller/user_subject_control_type_controller.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/model/enumeration/role_name.dart';
import 'package:mobile_electronic_record_card/page/student/record_card_page.dart';
import 'package:mobile_electronic_record_card/page/teacher/subject_page.dart';
import 'package:mobile_electronic_record_card/repository/impl/control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/group_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/role_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/student_mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/subject_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: Center(
            child: isSmallScreen
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Title(),
                      _FormContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(child: _Title()),
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            titleAuthPage,
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: blackColor),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent();

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  String? login;
  String? password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyLoginAuthPage;
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: labelLoginAuthPage,
                hintText: hintLoginAuthPage,
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => login = value,
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyPasswordAuthPage;
                }
                if (value.length < 12) {
                  return tinyPasswordAuthPage;
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: labelPasswordAuthPage,
                  hintText: hintPasswordAuthPage,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
              onChanged: (value) => password = value,
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: greatMarkColor),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    buttonAuthPage,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await authenticate();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> authenticate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserController().authenticate(login!, password!).then((user) {
      UserController().getByLoginFromServer(login!).then((value) {
        int? rolesCount = pref.getInt('rolesCount');
        List<String>? rolesName = pref.getStringList('rolesName');
        if (rolesCount != null && rolesName != null) {
          routeToPage(rolesCount, rolesName);
        }
      });
    }).catchError((onError) {
      Log.e('Ошибка авторизации под учетными данными: $login/$password');
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text('Неверная пара логин/пароль')));
    });
  }

  void data() async {
    await SubjectController().getAllFromServer();
    await ControlTypeController().getAllFromServer();
    await MarkController().getAllFromServer();
    await MarkControlTypeController().getAllFromServer();
    await GroupController().getAllFromServer();
    await RoleController().getAllFromServer();
    await UserController().getAllFromServer();
    await UserSubjectControlTypeController().getAllFromServer();
    await StudentMarkController().getAllFromServer();
  }

  void delete() async {
    await SubjectRepositoryImpl().deleteAll();
    await ControlTypeRepositoryImpl().deleteAll();
    await MarkRepositoryImpl().deleteAll();
    await MarkControlTypeRepositoryImpl().deleteAll();
    await GroupRepositoryImpl().deleteAll();
    await RoleRepositoryImpl().deleteAll();
    await UserRepositoryImpl().deleteAll();
    await UserSubjectControlTypeRepositoryImpl().deleteAll();
    await StudentMarkRepositoryImpl().deleteAll();
  }

  void routeToPage(int rolesCount, List<String> rolesName) {
    if (rolesCount == 1 && rolesName.first == RoleName.student) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const RecordCardPage(bottomNavBar: false),
          ),
          (Route<dynamic> route) => false);
    }
    if ((rolesCount == 1 && rolesName.first == RoleName.teacher) ||
        rolesCount == 2) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectPage(bottomNavBar: rolesCount != 1),
          ),
          (Route<dynamic> route) => false);
    }
  }

  Widget _gap() => const SizedBox(height: 16);
}
