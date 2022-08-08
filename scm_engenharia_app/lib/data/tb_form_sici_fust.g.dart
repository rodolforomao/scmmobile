// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_form_sici_fust.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TbFormSiciFust extends _TbFormSiciFust with RealmEntity, RealmObject {
  TbFormSiciFust(
      ObjectId idFichaSiciApp,
      String idEmpresa,
      String isSincronizar,
      String idLancamento,
      String periodoReferencia,
      String razaoSocial,
      String telefoneFixo,
      String cnpj,
      String telefoneMovel,
      String receitaBruta,
      String idFinanceiro,
      String simples,
      String simplesPorc,
      String icms,
      String icmsPorc,
      String pis,
      String pisPorc,
      String cofins,
      String cofinsPorc,
      String receitaLiquida,
      String observacoes,
      ) {
    RealmObject.set(this, 'idFichaSiciApp', idFichaSiciApp);
    RealmObject.set(this, 'idEmpresa', idEmpresa);
    RealmObject.set(this, 'isSincronizar', isSincronizar);
    RealmObject.set(this, 'idLancamento', idLancamento);
    RealmObject.set(this, 'periodoReferencia', periodoReferencia);
    RealmObject.set(this, 'razaoSocial', razaoSocial);
    RealmObject.set(this, 'telefoneFixo', telefoneFixo);
    RealmObject.set(this, 'cnpj', cnpj);
    RealmObject.set(this, 'telefoneMovel', telefoneMovel);
    RealmObject.set(this, 'receitaBruta', receitaBruta);
    RealmObject.set(this, 'idFinanceiro', idFinanceiro);
    RealmObject.set(this, 'simples', simples);
    RealmObject.set(this, 'simplesPorc', simplesPorc);
    RealmObject.set(this, 'icms', icms);
    RealmObject.set(this, 'icmsPorc', icmsPorc);
    RealmObject.set(this, 'pis', pis);
    RealmObject.set(this, 'pisPorc', pisPorc);
    RealmObject.set(this, 'cofins', cofins);
    RealmObject.set(this, 'cofinsPorc', cofinsPorc);
    RealmObject.set(this, 'receitaLiquida', receitaLiquida);
    RealmObject.set(this, 'observacoes', observacoes);
  }

  TbFormSiciFust._();

  @override
  ObjectId get idFichaSiciApp => RealmObject.get<ObjectId>(this, 'idFichaSiciApp') as ObjectId;
  @override
  set idFichaSiciApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idEmpresa => RealmObject.get<String>(this, 'idEmpresa') as String;
  @override
  set idEmpresa(String value) => RealmObject.set(this, 'idEmpresa', value);

  @override
  String get isSincronizar => RealmObject.get<String>(this, 'isSincronizar') as String;
  @override
  set isSincronizar(String value) => RealmObject.set(this, 'isSincronizar', value);

  @override
  String get idLancamento => RealmObject.get<String>(this, 'idLancamento') as String;
  @override
  set idLancamento(String value) => RealmObject.set(this, 'idLancamento', value);

  @override
  String get periodoReferencia => RealmObject.get<String>(this, 'periodoReferencia') as String;
  @override
  set periodoReferencia(String value) => RealmObject.set(this, 'periodoReferencia', value);

  @override
  String get razaoSocial => RealmObject.get<String>(this, 'razaoSocial') as String;
  @override
  set razaoSocial(String value) => RealmObject.set(this, 'razaoSocial', value);

  @override
  String get telefoneFixo => RealmObject.get<String>(this, 'telefoneFixo') as String;
  @override
  set telefoneFixo(String value) => RealmObject.set(this, 'telefoneFixo', value);

  @override
  String get cnpj => RealmObject.get<String>(this, 'cnpj') as String;
  @override
  set cnpj(String value) => RealmObject.set(this, 'cnpj', value);

  @override
  String get telefoneMovel => RealmObject.get<String>(this, 'telefoneMovel') as String;
  @override
  set telefoneMovel(String value) => RealmObject.set(this, 'telefoneMovel', value);

  @override
  String get receitaBruta => RealmObject.get<String>(this, 'receitaBruta') as String;
  @override
  set receitaBruta(String value) => RealmObject.set(this, 'receitaBruta', value);

  @override
  String get idFinanceiro => RealmObject.get<String>(this, 'idFinanceiro') as String;
  @override
  set idFinanceiro(String value) => RealmObject.set(this, 'idFinanceiro', value);

  @override
  String get simples => RealmObject.get<String>(this, 'simples') as String;
  @override
  set simples(String value) => RealmObject.set(this, 'simples', value);

  @override
  String get simplesPorc => RealmObject.get<String>(this, 'simplesPorc') as String;
  @override
  set simplesPorc(String value) => RealmObject.set(this, 'simplesPorc', value);

  @override
  String get icms => RealmObject.get<String>(this, 'icms') as String;
  @override
  set icmsPorc(String value) => RealmObject.set(this, 'icmsPorc', value);

  @override
  String get pis => RealmObject.get<String>(this, 'pis') as String;
  @override
  set pis(String value) => RealmObject.set(this, 'pis', value);

  @override
  String get pisPorc => RealmObject.get<String>(this, 'pisPorc') as String;
  @override
  set pisPorc(String value) => RealmObject.set(this, 'pisPorc', value);

  @override
  String get cofins => RealmObject.get<String>(this, 'cofins') as String;
  @override
  set cofins(String value) => RealmObject.set(this, 'cofins', value);

  @override
  String get cofinsPorc => RealmObject.get<String>(this, 'cofinsPorc') as String;
  @override
  set cofinsPorc(String value) => RealmObject.set(this, 'cofinsPorc', value);

  @override
  String get receitaLiquida => RealmObject.get<String>(this, 'receitaLiquida') as String;
  @override
  set receitaLiquida(String value) => RealmObject.set(this, 'receitaLiquida', value);

  @override
  String get observacoes => RealmObject.get<String>(this, 'observacoes') as String;
  @override
  set observacoes(String value) => RealmObject.set(this, 'observacoes', value);

  @override
  Stream<RealmObjectChanges<TbFormSiciFust>> get changes => RealmObject.getChanges<TbFormSiciFust>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbFormSiciFust._);
    return const SchemaObject(TbFormSiciFust, '_TbFormSiciFust', [
      SchemaProperty('idFichaSiciApp', RealmPropertyType.objectid, mapTo: 'idFichaSiciApp', primaryKey: true),
      SchemaProperty('idEmpresa', RealmPropertyType.string),
      SchemaProperty('isSincronizar', RealmPropertyType.string),
      SchemaProperty('idLancamento', RealmPropertyType.string),
      SchemaProperty('periodoReferencia', RealmPropertyType.string),
      SchemaProperty('razaoSocial', RealmPropertyType.string),
      SchemaProperty('telefoneFixo', RealmPropertyType.string),
      SchemaProperty('cnpj', RealmPropertyType.string),
      SchemaProperty('telefoneMovel', RealmPropertyType.string),
      SchemaProperty('receitaBruta', RealmPropertyType.string),
      SchemaProperty('idFinanceiro', RealmPropertyType.string),
      SchemaProperty('simples', RealmPropertyType.string),
      SchemaProperty('simplesPorc', RealmPropertyType.string),
      SchemaProperty('icms', RealmPropertyType.string),
      SchemaProperty('icmsPorc', RealmPropertyType.string),
      SchemaProperty('pis', RealmPropertyType.string),
      SchemaProperty('pisPorc', RealmPropertyType.string),
      SchemaProperty('cofins', RealmPropertyType.string),
      SchemaProperty('cofinsPorc', RealmPropertyType.string),
      SchemaProperty('receitaLiquida', RealmPropertyType.string),
      SchemaProperty('observacoes', RealmPropertyType.string),
    ]);
  }
}
