import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class BundledDbModel extends SqfEntityModelProvider {}

Future<String> createModelFromDatabase() async {
  final bundledDbModel = convertDatabaseToModelBase(BundledDbModel()
    ..databaseName = 'electronic_record_card.db'
    ..bundledDatabasePath = 'assets/electronic_record_card.sqlite');

  final String modelConstString =
  SqfEntityConverter(bundledDbModel as SqfEntityModelBase)
      .createConstDatabase();

  return modelConstString;
}