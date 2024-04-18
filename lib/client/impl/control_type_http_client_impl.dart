import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/entity/control_type_entity.dart';
import '../control_type_http_client.dart';
import '../../constants/api_constants.dart';

class ControlTypeHttpClientImpl implements ControlTypeHttpClient {
  @override
  Future<List<ControlTypeEntity>> getAll() async {
    final response = await http.get(Uri.parse(resourceUrl + controlTypeUrl));
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) =>
        ControlTypeEntity.fromJson(e)).toList();
  }

  @override
  Future<ControlTypeEntity> getById(int id) async {
    final response = await http.get(Uri.parse('$resourceUrl$controlTypeUrl/$id'));
    return ControlTypeEntity
        .fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  @override
  Future<ControlTypeEntity> getByName(String name) async {
    final response = await http.get(
        Uri.parse('$resourceUrl$controlTypeUrl$controlTypeGetByNameUrl/$name'));
    return ControlTypeEntity
        .fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

}