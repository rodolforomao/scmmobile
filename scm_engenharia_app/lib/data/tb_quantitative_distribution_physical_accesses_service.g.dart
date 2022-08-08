// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_quantitative_distribution_physical_accesses_service.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************


class TbQuantitativeDistributionPhysicalAccessesService extends _TbQuantitativeDistributionPhysicalAccessesService with RealmEntity, RealmObject {
  TbQuantitativeDistributionPhysicalAccessesService(
      ObjectId idApp,
   String idFichaSiciApp,
   String id,
   String cod_ibge,
   String id_uf,
   String id_municipio,
   String id_tecnologia,
   String pf_0,
   String pf_512,
   String pf_2,
   String pf_12,
   String pf_34,
   String pj_0,
   String pj_512,
   String pj_2,
   String pj_12,
   String pj_34,
   String id_lancamento,
   String id_usuario_ultima_alteracao,
   String municipio,
   String uf,
   String tecnologia,
 ) {
    RealmObject.set(this, 'idApp', idApp);
    RealmObject.set(this, 'idFichaSiciApp', idFichaSiciApp);
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'cod_ibge', cod_ibge);
    RealmObject.set(this, 'id_uf', id_uf);
    RealmObject.set(this, 'id_municipio', id_municipio);
    RealmObject.set(this, 'id_tecnologia', id_tecnologia);
    RealmObject.set(this, 'pf_0', pf_0);
    RealmObject.set(this, 'pf_512', pf_512);
    RealmObject.set(this, 'pf_2', pf_2);
    RealmObject.set(this, 'pf_12', pf_12);
    RealmObject.set(this, 'pf_34', pf_34);
    RealmObject.set(this, 'pj_0', pj_0);
    RealmObject.set(this, 'pj_512', pj_512);
    RealmObject.set(this, 'pj_2', pj_2);
    RealmObject.set(this, 'pj_12', pj_12);
    RealmObject.set(this, 'pj_34', pj_34);
    RealmObject.set(this, 'id_lancamento', id_lancamento);
    RealmObject.set(this, 'id_usuario_ultima_alteracao', id_usuario_ultima_alteracao);
    RealmObject.set(this, 'municipio', municipio);
    RealmObject.set(this, 'uf', uf);
    RealmObject.set(this, 'tecnologia', tecnologia);
  }

  TbQuantitativeDistributionPhysicalAccessesService._();

  @override
  ObjectId get idApp => RealmObject.get<ObjectId>(this, 'idApp') as ObjectId;
  @override
  set idApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idFichaSiciApp => RealmObject.get<String>(this, 'idFichaSiciApp') as String;
  @override
  set idFichaSiciApp(String value) => RealmObject.set(this, 'idFichaSiciApp', value);

  @override
  String get id => RealmObject.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObject.set(this, 'id', value);

  @override
  String get cod_ibge => RealmObject.get<String>(this, 'cod_ibge') as String;
  @override
  set cod_ibge(String value) => RealmObject.set(this, 'cod_ibge', value);

  @override
  String get id_uf => RealmObject.get<String>(this, 'id_uf') as String;
  @override
  set id_uf(String value) => RealmObject.set(this, 'id_uf', value);

  @override
  String get id_municipio => RealmObject.get<String>(this, 'id_municipio') as String;
  @override
  set id_municipio(String value) => RealmObject.set(this, 'id_municipio', value);

  @override
  String get id_tecnologia => RealmObject.get<String>(this, 'id_tecnologia') as String;
  @override
  set id_tecnologia(String value) => RealmObject.set(this, 'id_tecnologia', value);

  @override
  String get pf_0 => RealmObject.get<String>(this, 'pf_0') as String;
  @override
  set pf_0(String value) => RealmObject.set(this, 'pf_0', value);

  @override
  String get pf_512 => RealmObject.get<String>(this, 'pf_512') as String;
  @override
  set pf_512(String value) => RealmObject.set(this, 'pf_512', value);

  @override
  String get pf_2 => RealmObject.get<String>(this, 'pf_2') as String;
  @override
  set pf_2(String value) => RealmObject.set(this, 'pf_2', value);

  @override
  String get pf_12 => RealmObject.get<String>(this, 'pf_12') as String;
  @override
  set pf_12(String value) => RealmObject.set(this, 'pf_12', value);

  @override
  String get pf_34 => RealmObject.get<String>(this, 'pf_34') as String;
  @override
  set pf_34(String value) => RealmObject.set(this, 'pf_34', value);

  @override
  String get pj_0 => RealmObject.get<String>(this, 'pj_0') as String;
  @override
  set pj_0(String value) => RealmObject.set(this, 'pj_0', value);

  @override
  String get pj_512 => RealmObject.get<String>(this, 'pj_512') as String;
  @override
  set pj_512(String value) => RealmObject.set(this, 'pj_512', value);

  @override
  String get pj_2 => RealmObject.get<String>(this, 'pj_2') as String;
  @override
  set pj_2(String value) => RealmObject.set(this, 'pj_2', value);

  @override
  String get pj_12 => RealmObject.get<String>(this, 'pj_12') as String;
  @override
  set pj_12(String value) => RealmObject.set(this, 'pj_12', value);

  @override
  String get pj_34 => RealmObject.get<String>(this, 'pj_34') as String;
  @override
  set pj_34(String value) => RealmObject.set(this, 'pj_34', value);

  @override
  String get id_lancamento => RealmObject.get<String>(this, 'id_lancamento') as String;
  @override
  set id_lancamento(String value) => RealmObject.set(this, 'id_lancamento', value);

  @override
  String get id_usuario_ultima_alteracao => RealmObject.get<String>(this, 'id_usuario_ultima_alteracao') as String;
  @override
  set id_usuario_ultima_alteracao(String value) => RealmObject.set(this, 'id_usuario_ultima_alteracao', value);

  @override
  String get municipio => RealmObject.get<String>(this, 'municipio') as String;
  @override
  set municipio(String value) => RealmObject.set(this, 'municipio', value);

  @override
  String get uf => RealmObject.get<String>(this, 'uf') as String;
  @override
  set uf(String value) => RealmObject.set(this, 'uf', value);

  @override
  String get tecnologia => RealmObject.get<String>(this, 'tecnologia') as String;
  @override
  set tecnologia(String value) => RealmObject.set(this, 'tecnologia', value);

  @override
  Stream<RealmObjectChanges<TbQuantitativeDistributionPhysicalAccessesService>> get changes => RealmObject.getChanges<TbQuantitativeDistributionPhysicalAccessesService>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbQuantitativeDistributionPhysicalAccessesService._);
    return const SchemaObject(TbQuantitativeDistributionPhysicalAccessesService, '_TbQuantitativeDistributionPhysicalAccessesService', [
      SchemaProperty('idApp', RealmPropertyType.objectid, mapTo: 'idApp', primaryKey: true),
      SchemaProperty('idFichaSiciApp', RealmPropertyType.string),
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('cod_ibge', RealmPropertyType.string),
      SchemaProperty('id_uf', RealmPropertyType.string),
      SchemaProperty('id_municipio', RealmPropertyType.string),
      SchemaProperty('id_tecnologia', RealmPropertyType.string),
      SchemaProperty('pf_0', RealmPropertyType.string),
      SchemaProperty('pf_512', RealmPropertyType.string),
      SchemaProperty('pf_2', RealmPropertyType.string),
      SchemaProperty('pf_12', RealmPropertyType.string),
      SchemaProperty('pf_34', RealmPropertyType.string),
      SchemaProperty('pj_0', RealmPropertyType.string),
      SchemaProperty('pj_512', RealmPropertyType.string),
      SchemaProperty('pj_2', RealmPropertyType.string),
      SchemaProperty('pj_12', RealmPropertyType.string),
      SchemaProperty('pj_34', RealmPropertyType.string),
      SchemaProperty('id_lancamento', RealmPropertyType.string),
      SchemaProperty('id_usuario_ultima_alteracao', RealmPropertyType.string),
      SchemaProperty('municipio', RealmPropertyType.string),
      SchemaProperty('uf', RealmPropertyType.string),
      SchemaProperty('tecnologia', RealmPropertyType.string),
    ]);
  }
}
