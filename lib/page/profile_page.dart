import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/user_and_group_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/role_name.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/provider/user_provider.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final int? selectedItemNavBar;

  const ProfilePage({super.key, this.selectedItemNavBar});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final sharedLocator = getIt.get<SharedPreferenceHelper>();
  late int? userId;
  late int _selectedIndex;
  late BottomNavBarChoose bottomNavBar;
  List<String>? rolesName = [];
  bool _isPasswordVisible = false;
  String? oldPassword;
  String? password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userId = sharedLocator.getUserId();
    sharedLocator.getRolesName()?.forEach((element) {
      element == RoleName.student
          ? rolesName?.add('Студент')
          : rolesName?.add('Преподаватель');
    });
    userId != null
        ? Provider.of<UserProvider>(context, listen: false)
            .initCurrentUser(userId!)
        : null;
    _selectedIndex =
        widget.selectedItemNavBar ?? rolesName!.length;
    bottomNavBar = BottomNavBarChoose(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
          builder: (context, userProvider, _) =>
              buildFutureBuilder(userProvider)),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  FutureBuilder<UserAndGroupEntity> buildFutureBuilder(
      UserProvider userProvider) {
    return FutureBuilder(
      future: userProvider.currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const Expanded(flex: 2, child: _TopPortion()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data?.user.lastName} '
                        '${snapshot.data?.user.firstName} '
                        '${snapshot.data?.user.middleName ?? ''}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      _height(),
                      Row(
                        children: [
                          _width(),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        'Логин',
                                      )
                                    ],
                                  )))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Expanded(
                                      child: Column(
                                    children: [
                                      Text(snapshot.data?.user.login ?? '')
                                    ],
                                  ))))
                        ],
                      ),
                      _height(),
                      _height(),
                      Row(
                        children: [
                          _width(),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        rolesName?.length != 0 ? 'Роль' : '',
                                      )
                                    ],
                                  )))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Expanded(
                                      child: Column(
                                    children: [
                                      Text(rolesName?.length != 0 &&
                                              rolesName?.length == 1
                                          ? '${rolesName?[0]}'
                                          : rolesName?.length != 0 &&
                                                  rolesName?.length == 2
                                              ? '${rolesName?[0]}, '
                                                  '${rolesName?[1]}'
                                              : '')
                                    ],
                                  ))))
                        ],
                      ),
                      _height(),
                      Form(
                          key: _formKey,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _width(),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Expanded(
                                                child: Column(
                                              children: [
                                                Text(
                                                  'Старый пароль',
                                                )
                                              ],
                                            )))),
                                    Expanded(
                                        flex: 2,
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return emptyPasswordAuthPage;
                                                  }
                                                  if (value.length < 12) {
                                                    return tinyPasswordAuthPage;
                                                  }
                                                  return null;
                                                },
                                                obscureText:
                                                    !_isPasswordVisible,
                                                decoration: InputDecoration(
                                                    labelText:
                                                        labelPasswordAuthPage,
                                                    hintText:
                                                        hintPasswordAuthPage,
                                                    border:
                                                        const OutlineInputBorder(),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          _isPasswordVisible
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons
                                                                  .visibility),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isPasswordVisible =
                                                              !_isPasswordVisible;
                                                        });
                                                      },
                                                    )),
                                                onChanged: (value) =>
                                                    oldPassword = value,
                                              )),
                                            ],
                                          )
                                        ]))
                                  ],
                                ),
                                _height(),
                                Row(
                                  children: [
                                    _width(),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Expanded(
                                                child: Column(
                                              children: [
                                                Text(
                                                  'Пароль',
                                                )
                                              ],
                                            )))),
                                    Expanded(
                                        flex: 2,
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return emptyPasswordAuthPage;
                                                  }
                                                  if (value.length < 12) {
                                                    return tinyPasswordAuthPage;
                                                  }
                                                  return null;
                                                },
                                                obscureText:
                                                    !_isPasswordVisible,
                                                decoration: InputDecoration(
                                                    labelText:
                                                        labelPasswordAuthPage,
                                                    hintText:
                                                        hintPasswordAuthPage,
                                                    /*prefixIcon: const Icon(
                                              Icons.lock_outline_rounded),*/
                                                    border:
                                                        const OutlineInputBorder(),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          _isPasswordVisible
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons
                                                                  .visibility),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isPasswordVisible =
                                                              !_isPasswordVisible;
                                                        });
                                                      },
                                                    )),
                                                onChanged: (value) =>
                                                    password = value,
                                              )),
                                              IconButton(
                                                icon: const Icon(Icons.save_as),
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                          ?.validate() ??
                                                      false) {
                                                    // TODO добавить функцию смены пароля
                                                  }
                                                },
                                              )
                                            ],
                                          )
                                        ]))
                                  ],
                                )
                              ])),
                      _height(),
                      Row(
                        children: [
                          _width(),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Text(snapshot.data?.group?.name != null
                                          ? 'Группа'
                                          : '')
                                    ],
                                  ))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Text(snapshot.data?.group?.fullName ?? '')
                                    ],
                                  )))
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            ],
          );
        } else {
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text("Нет данных"),
                );
              });
        }
      },
    );
  }

  BottomNavigationBar? buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: bottomNavBar.getItems(),
      currentIndex: _selectedIndex,
      selectedItemColor: greatMarkColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    bottomNavBar.changeItem(index);
  }

  Widget _height() => const SizedBox(height: 16);

  Widget _width() => const SizedBox(width: 16);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [satisfactoryMarkColor, wellMarkColor]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: appbarColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/user.png'),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
