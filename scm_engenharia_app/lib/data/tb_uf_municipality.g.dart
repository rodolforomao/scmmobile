// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_uf_municipality.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************


class TbUfMunicipality extends _TbUfMunicipality with RealmEntity, RealmObject {
  TbUfMunicipality(
      ObjectId idMunicipalityApp,
      String idMunicipality,
      String uf,
      String id,
      String municipality
      ) {
    RealmObject.set(this, 'idMunicipalityApp', idMunicipalityApp);
    RealmObject.set(this, 'idMunicipality', idMunicipality);
    RealmObject.set(this, 'uf', uf);
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'municipality', municipality);
  }

  TbUfMunicipality._();

  @override
  ObjectId get idMunicipalityApp => RealmObject.get<ObjectId>(this, 'idMunicipalityApp') as ObjectId;
  @override
  set idMunicipalityApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idMunicipality => RealmObject.get<String>(this, 'idMunicipality') as String;
  @override
  set idMunicipality(String value) => RealmObject.set(this, 'idMunicipality', value);

  @override
  String get uf => RealmObject.get<String>(this, 'uf') as String;
  @override
  set uf(String value) => RealmObject.set(this, 'uf', value);

  @override
  String get id => RealmObject.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObject.set(this, 'id', value);

  @override
  String get municipality => RealmObject.get<String>(this, 'municipality') as String;
  @override
  set municipality(String value) => RealmObject.set(this, 'municipality', value);

  @override
  Stream<RealmObjectChanges<TbUfMunicipality>> get changes => RealmObject.getChanges<TbUfMunicipality>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbUfMunicipality._);
    return const SchemaObject(TbUfMunicipality, '_TbUfMunicipality', [
      SchemaProperty('idMunicipalityApp', RealmPropertyType.objectid, mapTo: 'idMunicipalityApp', primaryKey: true),
      SchemaProperty('idMunicipality', RealmPropertyType.string),
      SchemaProperty('uf', RealmPropertyType.string),
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('municipality', RealmPropertyType.string),
    ]);
  }
}
