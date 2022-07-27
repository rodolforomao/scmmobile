// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_technology.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************


class TbTechnology extends _TbTechnology with RealmEntity, RealmObject {
  TbTechnology(
      ObjectId idTechnologyApp,
      String idTechnology,
      String technology,
      ) {
    RealmObject.set(this, 'idTechnologyApp', idTechnologyApp);
    RealmObject.set(this, 'idTechnology', idTechnology);
    RealmObject.set(this, 'technology', technology);
  }

  TbTechnology._();

  @override
  ObjectId get idTechnologyApp => RealmObject.get<ObjectId>(this, 'idTechnologyApp') as ObjectId;
  @override
  set idTechnologyApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idTechnology => RealmObject.get<String>(this, 'idTechnology') as String;
  @override
  set idTechnology(String value) => RealmObject.set(this, 'idTechnology', value);

  @override
  String get technology => RealmObject.get<String>(this, 'technology') as String;
  @override
  set technology(String value) => RealmObject.set(this, 'technology', value);

  @override
  Stream<RealmObjectChanges<TbTechnology>> get changes => RealmObject.getChanges<TbTechnology>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbTechnology._);
    return const SchemaObject(TbTechnology, '_TbTechnology', [
      SchemaProperty('idTechnologyApp', RealmPropertyType.objectid, mapTo: 'idTechnologyApp', primaryKey: true),
      SchemaProperty('idTechnology', RealmPropertyType.string),
      SchemaProperty('technology', RealmPropertyType.string),
    ]);
  }
}
