// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_uf.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************


class TbUf extends _TbUf with RealmEntity, RealmObject {
  TbUf(
      ObjectId idUfApp,
      String id,
      String uf,
      ) {
    RealmObject.set(this, 'idUfApp', idUfApp);
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'uf', uf);
  }

  TbUf._();

  @override
  ObjectId get idUfApp => RealmObject.get<ObjectId>(this, 'idUfApp') as ObjectId;
  @override
  set idUfApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get id => RealmObject.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObject.set(this, 'id', value);

  @override
  String get uf => RealmObject.get<String>(this, 'uf') as String;
  @override
  set uf(String value) => RealmObject.set(this, 'uf', value);



  @override
  Stream<RealmObjectChanges<TbUf>> get changes => RealmObject.getChanges<TbUf>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbUf._);
    return const SchemaObject(TbUf, '_TbUf', [
      SchemaProperty('idUfApp', RealmPropertyType.objectid, mapTo: 'idUfApp', primaryKey: true),
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('uf', RealmPropertyType.string),
    ]);
  }
}
