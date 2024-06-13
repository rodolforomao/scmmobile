// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_arquivo_dici_fust.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TbArquivoDiciFust extends _TbArquivoDiciFust  with RealmEntity, RealmObjectBase, RealmObject {
  TbArquivoDiciFust(
      ObjectId idArquivoDiciFustApp,
      String? idRegistro,
      String? result,
      ) {
    RealmObjectBase.set(this, 'idArquivoDiciFustApp', idArquivoDiciFustApp);
    RealmObjectBase.set(this, 'idRegistro', idRegistro);
    RealmObjectBase.set(this, 'result', result);
  }

  TbArquivoDiciFust._();

  @override
  ObjectId get idArquivoDiciFustApp => RealmObjectBase.get<ObjectId>(this, 'idArquivoDiciFustApp') as ObjectId;
  @override
  set idArquivoDiciFustApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idRegistro => RealmObjectBase.get<String>(this, 'idRegistro') as String;
  @override
  set idRegistro(String value) => RealmObjectBase.set(this, 'idRegistro', value);

  @override
  String get result => RealmObjectBase.get<String>(this, 'result') as String;
  @override
  set result(String value) => RealmObjectBase.set(this, 'result', value);



  @override
  Stream<RealmObjectChanges<TbArquivoDiciFust>> get changes => RealmObjectBase.getChanges<TbArquivoDiciFust>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TbArquivoDiciFust._);
    return SchemaObject(ObjectType.realmObject, TbArquivoDiciFust, 'TbArquivoDiciFust', [
      SchemaProperty('idArquivoDiciFustApp', RealmPropertyType.objectid, mapTo: 'idArquivoDiciFustApp', primaryKey: true),
      SchemaProperty('idRegistro', RealmPropertyType.string),
      SchemaProperty('result', RealmPropertyType.string),
    ]);
  }
}
