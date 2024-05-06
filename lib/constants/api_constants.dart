import 'package:flutter/material.dart';

// Строковые переменные для отправки запроса

const String resourceUrl = 'http://192.168.3.67:8080/';

const String controlTypeUrl = 'api/control-types';
const String controlTypeGetByVersionUrl = '/version/';
const String controlTypeWithMarksUrl = '/with-marks';

const String groupUrl = 'api/groups';
const String groupGetByVersionUrl = '/version/';
const String groupAndCriteriaUrl = '/filter';

const String markUrl = 'api/marks';
const String markGetByVersionUrl = '/version/';

const String roleUrl = 'api/roles';

const String subjectUrl = 'api/subjects';
const String subjectGetByVersionUrl = '/version/';

const String userUrl = 'api/users';
const String userGetByVersionUrl = '/version/';
const String userAndCriteriaUrl = '/filter';
const String userByLoginUrl = '/login';
const String userAuthenticateUrl = '/authenticate';

const String usctUrl = 'api/user-subject-control-types';
const String usctGetByVersionUrl = '/version/';
const String usctAndCriteriaUrl = '/filter';

const Map<String, String> headers = {
  "Accept": "application/json",
  "content-type": "application/json"
};

//  Строковые переменные для страницы авторизации
const String titleAuthPage = 'Электронная зачетка';

const String labelLoginAuthPage = 'Логин';
const String hintLoginAuthPage = 'Введите логин';
const String emptyLoginAuthPage = 'Пожалуйста, введите логин';

const String labelPasswordAuthPage = 'Пароль';
const String hintPasswordAuthPage = 'Введите пароль';
const String emptyPasswordAuthPage = 'Пожалуйста, введите пароль';
const String tinyPasswordAuthPage = 'Пароль должен быть не меньше 12 символов';

const String buttonAuthPage = 'Вход';

//  Строковые переменные для страницы предметов
const String titleSubjectPage = 'Предметы';
const String hintSearch = 'Введите значение для поиска';

//  Строковые переменные для страницы групп
const String titleGroupPage = 'Группы';

// Цветовые решения
const Color appbarColor = Color.fromARGB(255, 245, 245, 245);
const Color noMarkColor = Color.fromARGB(255, 230, 230, 230);
const Color failMarkColor = Color.fromARGB(255, 243, 185, 180);
const Color satisfactoryMarkColor = Color.fromARGB(255, 218, 237, 184);
const Color wellMarkColor = Color.fromARGB(255, 199, 229, 150);
const Color greatMarkColor = Color.fromARGB(255, 175, 218, 105);
const Color blackColor = Colors.black;
const Color greyColor = Colors.white30;