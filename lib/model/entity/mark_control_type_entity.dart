class MarkControlTypeEntity {
  int? markId;
  int? controlTypeId;

  MarkControlTypeEntity({
    this.markId,
    this.controlTypeId
  });

  static MarkControlTypeEntity fromJson(Map<String, dynamic> json){
    var markId = json['mark_id'];
    var controlTypeId = json['control_type_id'];
    return MarkControlTypeEntity(markId: markId, controlTypeId: controlTypeId);
  }

  static List<MarkControlTypeEntity> fromJsonWithMarks(Map<String, dynamic> json) {
    List<MarkControlTypeEntity> list = [];
    var markId = json['markIds'];
    var controlTypeId = json['controlTypeId'];
    markId.forEach((element) {
      list.add(MarkControlTypeEntity(markId: element, controlTypeId: controlTypeId));
    });
    return list;
  }

  static Map<String, dynamic> toJson(MarkControlTypeEntity markControlType) {
    return {
      'mark_id': markControlType.markId,
      'control_type_id': markControlType.controlTypeId,
    };
  }
}