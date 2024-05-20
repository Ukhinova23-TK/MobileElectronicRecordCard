import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String userId = 'userId';
  static const String groupId = 'groupId';
  static const String rolesCount = 'rolesCount';
  static const String rolesName = 'rolesName';
  static const String needSave = 'needSave';
  static const String deletionVersion = 'deletionVersion';

  final SharedPreferences prefs;

  SharedPreferenceHelper({required this.prefs});

  bool? getNeedSave() => prefs.getBool(needSave);

  Future<bool> deleteNeedSave() => prefs.remove(needSave);

  Future<bool> setNeedSave(bool value) => prefs.setBool(needSave, value);

  int? getUserId() => prefs.getInt(userId);

  Future<bool> setUserId(int value) => prefs.setInt(userId, value);

  Future<bool> deleteUserId() => prefs.remove(userId);

  int? getGroupId() => prefs.getInt(groupId);

  Future<bool> setGroupId(int value) => prefs.setInt(groupId, value);

  Future<bool> deleteGroupId() => prefs.remove(groupId);

  int? getRolesCount() => prefs.getInt(rolesCount);

  Future<bool> setRolesCount(int value) => prefs.setInt(rolesCount, value);

  Future<bool> deleteRolesCount() => prefs.remove(rolesCount);

  List<String>? getRolesName() => prefs.getStringList(rolesName);

  Future<bool> setRolesName(List<String> value) =>
      prefs.setStringList(rolesName, value);

  Future<bool> deleteRolesName() => prefs.remove(rolesName);

  int? getDeletionVersion() => prefs.getInt(deletionVersion);

  Future<bool> setDeletionVersion(int value) => prefs.setInt(deletionVersion, value);

  Future<bool> deleteDeletionVersion() => prefs.remove(deletionVersion);

  void deleteAll() {
    prefs.remove(userId);
    prefs.remove(groupId);
    prefs.remove(rolesCount);
    prefs.remove(rolesName);
    prefs.remove(needSave);
    prefs.remove(deletionVersion);
  }
}
