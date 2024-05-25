import 'package:collection/collection.dart';

import 'package:mobile_electronic_record_card/client/control_type_http_client.dart';
import 'package:mobile_electronic_record_card/client/deletion_http_client.dart';
import 'package:mobile_electronic_record_card/client/group_http_client.dart';
import 'package:mobile_electronic_record_card/client/impl/control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/deletion_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/group_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/mark_control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/mark_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/role_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/student_mark_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/subject_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/user_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/impl/user_subject_control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/client/mark_control_type_http_client.dart';
import 'package:mobile_electronic_record_card/client/mark_http_client.dart';
import 'package:mobile_electronic_record_card/client/role_http_client.dart';
import 'package:mobile_electronic_record_card/client/student_mark_http_client.dart';
import 'package:mobile_electronic_record_card/client/subject_http_client.dart';
import 'package:mobile_electronic_record_card/client/user_http_client.dart';
import 'package:mobile_electronic_record_card/client/user_subject_control_type_http_client.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/delete_controller.dart';
import 'package:mobile_electronic_record_card/controller/group_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_controller.dart';
import 'package:mobile_electronic_record_card/controller/role_controller.dart';
import 'package:mobile_electronic_record_card/controller/student_mark_controller.dart';
import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/controller/user_controller.dart';
import 'package:mobile_electronic_record_card/controller/user_subject_control_type_controller.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/deletion_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/student_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/entity_type.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:mobile_electronic_record_card/service/synchronization/synchronization_service.dart';

class SynchronizationServiceImpl implements SynchronizationService {
  RoleHttpClient roleHttpClient = RoleHttpClientImpl();
  MarkHttpClient markHttpClient = MarkHttpClientImpl();
  ControlTypeHttpClient controlTypeHttpClient = ControlTypeHttpClientImpl();
  MarkControlTypeHttpClient markControlTypeHttpClient =
      MarkControlTypeHttpClientImpl();
  DeletionHttpClient deletionHttpClient = DeletionHttpClientImpl();
  SubjectHttpClient subjectHttpClient = SubjectHttpClientImpl();
  GroupHttpClient groupHttpClient = GroupHttpClientImpl();
  UserHttpClient userHttpClient = UserHttpClientImpl();
  UserSubjectControlTypeHttpClient userSubjectControlTypeHttpClient =
      UserSubjectControlTypeHttpClientImpl();
  StudentMarkHttpClient studentMarkHttpClient = StudentMarkHttpClientImpl();

  RoleController roleController = RoleController();
  MarkController markController = MarkController();
  ControlTypeController controlTypeController = ControlTypeController();
  MarkControlTypeController markControlTypeController =
      MarkControlTypeController();
  SubjectController subjectController = SubjectController();
  GroupController groupController = GroupController();
  UserController userController = UserController();
  UserSubjectControlTypeController userSubjectControlTypeController =
      UserSubjectControlTypeController();
  StudentMarkController studentMarkController = StudentMarkController();

  final secureLocator = getIt.get<SecureStorageHelper>();
  final sharedLocator = getIt.get<SharedPreferenceHelper>();

  @override
  Future<void> fetch() async {
    Map<String, DeleteController> deleteMap = {
      EntityType.studentMark: studentMarkController,
      EntityType.userSubjectControlType: userSubjectControlTypeController,
      EntityType.user: userController,
      EntityType.group: groupController,
      EntityType.subject: subjectController
    };
    var deletionFuture = deletionHttpClient.getAll();
    await roleController.setAllToDb(await roleHttpClient.getAll());
    var markFuture = markController.setAllToDb(await markHttpClient.getAll());
    var controlTypeFuture =
        controlTypeController.setAllToDb(await controlTypeHttpClient.getAll());
    await Future.wait([markFuture, controlTypeFuture]);
    var markControlTypeFuture = markControlTypeController
        .setAllToDb(await markControlTypeHttpClient.getAll());
    var subjectFuture =
        subjectController.setAllToDb(await subjectHttpClient.getAll());
    var groupFuture =
        groupController.setAllToDb(await groupHttpClient.getAll());
    await Future.wait([markControlTypeFuture, subjectFuture, groupFuture]);
    await userController.setAllToDb(await userHttpClient.getAll());
    await userSubjectControlTypeController
        .setAllToDb(await userSubjectControlTypeHttpClient.getAll());
    await _updateStudentMarks(await studentMarkHttpClient.getAll());

    var deletions = await deletionFuture;
    if(deletions.isNotEmpty){
      deletions.length > 2
          ? deletions.sort((del1, del2) => del1.version!.compareTo(del2.version!))
          : null;
      sharedLocator.setDeletionVersion(deletions.last.version ?? 0);
    }

    var groupedDeletions =
        groupBy(deletions, (DeletionEntity deletion) => deletion.entityType);
    for (var entityType in [
      EntityType.studentMark,
      EntityType.userSubjectControlType,
      EntityType.user,
      EntityType.group,
      EntityType.subject
    ]) {
      if (groupedDeletions[entityType] != null &&
          deleteMap[entityType] != null) {
        await _deleteAllEntities(
            groupedDeletions[entityType]!.map((element) => element.id).toList(),
            deleteMap[entityType]!);
      }
    }
  }

  @override
  Future<void> push(List<StudentMarkEntity> studentMarks) async {
    List<StudentMarkEntity> newStudentMarks =
        await studentMarkHttpClient.push(studentMarks);
    await _updateStudentMarks(newStudentMarks);
  }

  Future<void> _updateStudentMarks(List<StudentMarkEntity> studentMarks) async {
    var futureList = <Future>[];
    for (var element in studentMarks) {
      if (element.userSubjectControlTypeId == null) {
        continue;
      }
      if ((await studentMarkController.getByUserSubjectControlTypeFromDb(
              element.userSubjectControlTypeId!)) ==
          null) {
        futureList.add(studentMarkController.setToDb(element));
      } else {
        futureList.add(studentMarkController.updateToDb(element));
      }
    }
    await Future.wait(futureList);
  }

  Future<void> _deleteAllEntities(
      List<int?> ids, DeleteController controller) async {
    await Future.wait(ids
        .where((element) => element != null)
        .map((element) => controller.delete(element!)));
  }

  @override
  Future<void> clearDb() async {
    await userHttpClient.logout();
    await studentMarkController.deleteAll();
    await userSubjectControlTypeController.deleteAll();
    await userController.deleteAll();
    await groupController.deleteAll();
    await subjectController.deleteAll();
  }

  @override
  void clearPreferences() {
    sharedLocator.deleteAll();
    secureLocator.removeAll();
  }
}
