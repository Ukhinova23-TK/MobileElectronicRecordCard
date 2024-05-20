class DeletionEntity {
  int? id;
  String? entityType;
  int? entityId;
  int? version;

  DeletionEntity({this.id, this.entityType, this.entityId, this.version});

  static DeletionEntity fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var entityType = json['entityType'];
    var entityId = json['entityId'];
    var version = json['version'];
    return DeletionEntity(
        id: id, entityType: entityType, entityId: entityId, version: version);
  }

  static Map<String, dynamic> toJson(DeletionEntity deletion) {
    return {
      'id': deletion.id,
      'entityType': deletion.entityType,
      'entityId': deletion.entityId,
      'version': deletion.version
    };
  }
}
