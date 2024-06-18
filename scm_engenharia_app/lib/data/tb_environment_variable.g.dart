// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_environment_variable.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TbEnvironmntVariable extends _TbEnvironmntVariable  with RealmEntity, RealmObjectBase, RealmObject {
  TbEnvironmntVariable(
      ObjectId idEnvironmntVariableApp,
      String? result,
      ) {
    RealmObjectBase.set(this, 'idEnvironmntVariableApp', idEnvironmntVariableApp);
    RealmObjectBase.set(this, 'result', result);
  }

  TbEnvironmntVariable._();

  @override
  ObjectId get idEnvironmntVariableApp => RealmObjectBase.get<ObjectId>(this, 'idEnvironmntVariableApp') as ObjectId;
  @override
  set idEnvironmntVariableApp(ObjectId value) => throw RealmUnsupportedSetError();


  @override
  String get result => RealmObjectBase.get<String>(this, 'result') as String;
  @override
  set result(String value) => RealmObjectBase.set(this, 'result', value);

  @override
  Stream<RealmObjectChanges<TbEnvironmntVariable>> get changes => RealmObjectBase.getChanges<TbEnvironmntVariable>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TbEnvironmntVariable._);
    return  SchemaObject(ObjectType.realmObject, TbEnvironmntVariable, 'TbEnvironmntVariable', [
      SchemaProperty('idEnvironmntVariableApp', RealmPropertyType.objectid, mapTo: 'idEnvironmntVariableApp', primaryKey: true),
      SchemaProperty('result', RealmPropertyType.string),
    ]);
  }
}
