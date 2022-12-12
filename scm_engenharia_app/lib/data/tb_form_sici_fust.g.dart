// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_form_sici_fust.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TbFormSiciFust extends _TbFormSiciFust  with RealmEntity, RealmObject {
  TbFormSiciFust(
      ObjectId idFormSiciFustApp,
      String? idRegistro,
      String? result,
      ) {
    RealmObject.set(this, 'idFormSiciFustApp', idFormSiciFustApp);
    RealmObject.set(this, 'idRegistro', idRegistro);
    RealmObject.set(this, 'result', result);
  }

  TbFormSiciFust._();

  @override
  ObjectId get idFichaSiciApp => RealmObject.get<ObjectId>(this, 'idFormSiciFustApp') as ObjectId;
  @override
  set idFichaSiciApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idRegistro => RealmObject.get<String>(this, 'idRegistro') as String;
  @override
  set idRegistro(String value) => RealmObject.set(this, 'idRegistro', value);

  @override
  String get result => RealmObject.get<String>(this, 'result') as String;
  @override
  set result(String value) => RealmObject.set(this, 'result', value);



  @override
  Stream<RealmObjectChanges<TbFormSiciFust>> get changes => RealmObject.getChanges<TbFormSiciFust>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbFormSiciFust._);
    return const SchemaObject(TbFormSiciFust, '_TbFormSiciFust', [
      SchemaProperty('idFormSiciFustApp', RealmPropertyType.objectid, mapTo: 'idFormSiciFustApp', primaryKey: true),
      SchemaProperty('idRegistro', RealmPropertyType.string),
      SchemaProperty('result', RealmPropertyType.string),
    ]);
  }
}
