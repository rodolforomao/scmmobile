// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_form_sici_fust.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TbFormSiciFust extends _TbFormSiciFust  with RealmEntity, RealmObjectBase, RealmObject {
  TbFormSiciFust(
      ObjectId idFormSiciFustApp,
      String? idRegistro,
      String? result,
      ) {
    RealmObjectBase.set(this, 'idFormSiciFustApp', idFormSiciFustApp);
    RealmObjectBase.set(this, 'idRegistro', idRegistro);
    RealmObjectBase.set(this, 'result', result);
  }

  TbFormSiciFust._();

  @override
  ObjectId get idFichaSiciApp => RealmObjectBase.get<ObjectId>(this, 'idFormSiciFustApp') as ObjectId;
  @override
  set idFichaSiciApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idRegistro => RealmObjectBase.get<String>(this, 'idRegistro') as String;
  @override
  set idRegistro(String value) => RealmObjectBase.set(this, 'idRegistro', value);

  @override
  String get result => RealmObjectBase.get<String>(this, 'result') as String;
  @override
  set result(String value) => RealmObjectBase.set(this, 'result', value);



  @override
  Stream<RealmObjectChanges<TbFormSiciFust>> get changes => RealmObjectBase.getChanges<TbFormSiciFust>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TbFormSiciFust._);
    return const SchemaObject(ObjectType.realmObject, TbFormSiciFust, 'TbFormSiciFust', [
      SchemaProperty('idFormSiciFustApp', RealmPropertyType.objectid, mapTo: 'idFormSiciFustApp', primaryKey: true),
      SchemaProperty('idRegistro', RealmPropertyType.string),
      SchemaProperty('result', RealmPropertyType.string),
    ]);
  }
}
