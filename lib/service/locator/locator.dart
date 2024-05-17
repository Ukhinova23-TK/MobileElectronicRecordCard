import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs: prefs),
  );
  const secureStorage = FlutterSecureStorage();
  getIt.registerSingleton<SecureStorageHelper>(
      SecureStorageHelper(secureStorage: secureStorage));
}
