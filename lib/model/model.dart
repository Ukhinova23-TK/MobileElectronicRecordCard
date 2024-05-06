import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part "model.g.dart";

const SqfEntityTable tableRole = SqfEntityTable(
  tableName: 'role',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_unique,
  modelName: null,
  fields: [
    SqfEntityField('name', DbType.text, isNotNull: true),
    SqfEntityFieldRelationship(
      parentTable: tableUser,
      relationType: RelationType.MANY_TO_MANY,
      manyToManyTableName: 'user_role'
    )
  ]
);

const SqfEntityTable tableGroup = SqfEntityTable(
  tableName: 'student_group',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_unique,
  modelName: null,
  fields: [
    SqfEntityField('name', DbType.text, isNotNull: true),
    SqfEntityField('full_name', DbType.text),
    SqfEntityField('admission_date', DbType.date),
    SqfEntityField('version', DbType.integer, isNotNull: true)
  ]
);

const SqfEntityTable tableMark = SqfEntityTable(
  tableName: 'mark',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_unique,
  modelName: null,
  fields: [
    SqfEntityField('name', DbType.text, isNotNull: true),
    SqfEntityField('title', DbType.text, isNotNull: true),
    SqfEntityField('value', DbType.integer, isNotNull: true),
    SqfEntityField('version', DbType.integer, isNotNull: true)
  ]
);

const SqfEntityTable tableControlType = SqfEntityTable(
  tableName: 'control_type',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_unique,
  modelName: null,
  fields: [
    SqfEntityField('name', DbType.text, isNotNull: true),
    SqfEntityField('title', DbType.text, isNotNull: true),
    SqfEntityField('version', DbType.integer, isNotNull: true),
    SqfEntityFieldRelationship(
        parentTable: tableMark,
        relationType: RelationType.MANY_TO_MANY,
        manyToManyTableName: 'mark_control_type'
    )
  ]
);

const SqfEntityTable tableSubject = SqfEntityTable(
  tableName: 'subject',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_unique,
  modelName: null,
  fields: [
    SqfEntityField('name', DbType.text, isNotNull: true),
    SqfEntityField('version', DbType.integer, isNotNull: true)
  ]
);

const SqfEntityTable tableUser = SqfEntityTable(
    tableName: 'user',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_unique,
    modelName: null,
    fields: [
      SqfEntityField('login', DbType.text, isNotNull: true),
      SqfEntityField('last_name', DbType.text, isNotNull: true),
      SqfEntityField('first_name', DbType.text, isNotNull: true),
      SqfEntityField('middle_name', DbType.text),
      SqfEntityField('version', DbType.integer, isNotNull: true),
      SqfEntityFieldRelationship(
        parentTable: tableGroup,
        fieldName: 'groupId',
        relationType: RelationType.ONE_TO_MANY
      )
    ]
);

const SqfEntityTable tableUserSubjectControlType = SqfEntityTable(
  tableName: 'user_subject_control_type',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_unique,
  modelName: null,
  fields: [
    SqfEntityField('semester', DbType.integer, isNotNull: true),
    SqfEntityField('hours_number', DbType.integer),
    SqfEntityField('version', DbType.integer, isNotNull: true),
    SqfEntityFieldRelationship(
      parentTable: tableUser,
      fieldName: 'teacher_id',
      relationType: RelationType.ONE_TO_MANY
    ),
    SqfEntityFieldRelationship(
        parentTable: tableSubject,
        fieldName: 'subject_id',
        relationType: RelationType.ONE_TO_MANY
    ),
    SqfEntityFieldRelationship(
        parentTable: tableControlType,
        fieldName: 'control_type_id',
        relationType: RelationType.ONE_TO_MANY
    ),
    SqfEntityFieldRelationship(
        parentTable: tableUser,
        fieldName: 'student_id',
        relationType: RelationType.ONE_TO_MANY
    ),
  ]
);

const SqfEntityTable tableStudentMark = SqfEntityTable(
  tableName: 'student_mark',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_unique,
  modelName: null,
  fields: [
    SqfEntityField('completion_date', DbType.date),
    SqfEntityField('version', DbType.integer, isNotNull: true),
    SqfEntityFieldRelationship(
      parentTable: tableMark,
      fieldName: 'mark_id',
      relationType: RelationType.ONE_TO_MANY
    ),
    SqfEntityFieldRelationship(
        parentTable: tableUserSubjectControlType,
        fieldName: 'user_subject_control_type_id',
        relationType: RelationType.ONE_TO_MANY
    )
  ]
);

@SqfEntityBuilder(electronicRecordCardDbModel)
const SqfEntityModel electronicRecordCardDbModel = SqfEntityModel(
  modelName: null,
  databaseName: 'electronic_record_card.db',
  databaseTables: [
    tableRole,
    tableGroup,
    tableSubject,
    tableMark,
    tableControlType,
    tableUser,
    tableUserSubjectControlType,
    tableStudentMark
  ],
  bundledDatabasePath: null
);

