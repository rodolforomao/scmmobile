// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_quantitative_distribution_physical_accesses_service.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************


class TbQuantitativeDistributionPhysicalAccessesService extends _TbQuantitativeDistributionPhysicalAccessesService with RealmEntity, RealmObject {
  TbQuantitativeDistributionPhysicalAccessesService(
      ObjectId idQuantitativeDistributionPhysicalAccessesServiceApp,
      String idTechnology,
      String technology,
      ) {
    RealmObject.set(this, 'idQuantitativeDistributionPhysicalAccessesServiceApp', idQuantitativeDistributionPhysicalAccessesServiceApp);
    RealmObject.set(this, 'idTechnology', idTechnology);
    RealmObject.set(this, 'technology', technology);
  }

  TbQuantitativeDistributionPhysicalAccessesService._();

  @override
  ObjectId get idQuantitativeDistributionPhysicalAccessesServiceApp => RealmObject.get<ObjectId>(this, 'idQuantitativeDistributionPhysicalAccessesServiceApp') as ObjectId;
  @override
  set idQuantitativeDistributionPhysicalAccessesServiceApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idTechnology => RealmObject.get<String>(this, 'idTechnology') as String;
  @override
  set idTechnology(String value) => RealmObject.set(this, 'idTechnology', value);

  @override
  String get technology => RealmObject.get<String>(this, 'technology') as String;
  @override
  set technology(String value) => RealmObject.set(this, 'technology', value);

  @override
  Stream<RealmObjectChanges<TbQuantitativeDistributionPhysicalAccessesService>> get changes => RealmObject.getChanges<TbQuantitativeDistributionPhysicalAccessesService>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbQuantitativeDistributionPhysicalAccessesService._);
    return const SchemaObject(TbQuantitativeDistributionPhysicalAccessesService, '_TbQuantitativeDistributionPhysicalAccessesService', [
      SchemaProperty('idTechnologyApp', RealmPropertyType.objectid, mapTo: 'idTechnologyApp', primaryKey: true),
      SchemaProperty('idTechnology', RealmPropertyType.string),
      SchemaProperty('technology', RealmPropertyType.string),
    ]);
  }
}
