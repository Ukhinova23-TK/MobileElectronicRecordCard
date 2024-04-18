import '../../../model/entity/mark_entity.dart';
import '../../../model/model.dart';
import '../mapper.dart';

class MarkMapper implements Mapper<MarkEntity, Mark> {
  @override
  MarkEntity toEntity(Mark model) {
    return MarkEntity(
      id: model.id,
      name: model.name,
      title: model.title,
      value: model.value
    );
  }

  @override
  Mark toModel(MarkEntity entity) {
    return Mark(
        id: entity.id,
        name: entity.name,
        title: entity.title,
        value: entity.value
    );
  }

}