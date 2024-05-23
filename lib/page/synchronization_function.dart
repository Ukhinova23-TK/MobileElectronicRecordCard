import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/page/authorization_page.dart';
import 'package:mobile_electronic_record_card/service/synchronization/impl/synchronization_service_impl.dart';

Future<void> logout(BuildContext context) async {
  var synchronizationService = SynchronizationServiceImpl();
  await synchronizationService.clearDb();
  synchronizationService.clearPreferences();
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthorizationPage(),
      ),
      (Route<dynamic> route) => false);
}

Future<void> synchronization() async {
  var synchronizationService = SynchronizationServiceImpl();
  await synchronizationService.fetch();
}
