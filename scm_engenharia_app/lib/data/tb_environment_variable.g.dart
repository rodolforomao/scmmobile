// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_environment_variable.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TbEnvironmntVariable extends _TbEnvironmntVariable  with RealmEntity, RealmObject {
  TbEnvironmntVariable(
      ObjectId idEnvironmntVariableApp,
      String? result,
      ) {
    RealmObject.set(this, 'idEnvironmntVariableApp', idEnvironmntVariableApp);
    RealmObject.set(this, 'result', result);
  }

  TbEnvironmntVariable._();

  @override
  ObjectId get idEnvironmntVariableApp => RealmObject.get<ObjectId>(this, 'idEnvironmntVariableApp') as ObjectId;
  @override
  set idEnvironmntVariableApp(ObjectId value) => throw RealmUnsupportedSetError();


  @override
  String get result => RealmObject.get<String>(this, 'result') as String;
  @override
  set result(String value) => RealmObject.set(this, 'result', value);

  @override
  Stream<RealmObjectChanges<TbEnvironmntVariable>> get changes => RealmObject.getChanges<TbEnvironmntVariable>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbEnvironmntVariable._);
    return const SchemaObject(TbEnvironmntVariable, '_TbEnvironmntVariable', [
      SchemaProperty('idEnvironmntVariableApp', RealmPropertyType.objectid, mapTo: 'idEnvironmntVariableApp', primaryKey: true),
      SchemaProperty('result', RealmPropertyType.string),
    ]);
  }
}
