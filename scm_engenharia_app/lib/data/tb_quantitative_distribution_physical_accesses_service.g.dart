// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_quantitative_distribution_physical_accesses_service.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************


class TbQuantitativeDistributionPhysicalAccessesService extends _TbQuantitativeDistributionPhysicalAccessesService with RealmEntity, RealmObject {
  TbQuantitativeDistributionPhysicalAccessesService(ObjectId idApp,
      String idFichaSiciApp,
      String cnpj,
      String ano,
      String mes,

      String codIbgeId,
      String codIbgeDescricao,
      String codIbge,
      String codIbgeIdUf,

      String tipoClienteId,
      String tipoCliente,

      String tipoAtendimentoId,
      String tipoAtendimento,

      String tipoMeioId,
      String tipoMeio,

      String tipoProdutoId,
      String tipoProduto,

      String tipoTecnologiaId,
      String tipoTecnologiaDescricao,
      String tipoTecnologiaIdTipoMeioAcesso,
      String tipoTecnologiaIdTipoProduto,

      String acessos,
      String velocidade,
 ) {
    RealmObject.set(this, 'idApp', idApp);
    RealmObject.set(this, 'idFichaSiciApp', idFichaSiciApp);
    RealmObject.set(this, 'cnpj', cnpj);
    RealmObject.set(this, 'ano', ano);
    RealmObject.set(this, 'mes', mes);
    RealmObject.set(this, 'codIbgeId', codIbgeId);
    RealmObject.set(this, 'codIbgeDescricao', codIbgeDescricao);
    RealmObject.set(this, 'codIbge', codIbge);
    RealmObject.set(this, 'codIbgeIdUf', codIbgeIdUf);
    RealmObject.set(this, 'tipoClienteId', tipoClienteId);
    RealmObject.set(this, 'tipoCliente', tipoCliente);
    RealmObject.set(this, 'tipoAtendimentoId', tipoAtendimentoId);
    RealmObject.set(this, 'tipoAtendimento', tipoAtendimento);
    RealmObject.set(this, 'tipoMeioId', tipoMeioId);
    RealmObject.set(this, 'tipoMeio', tipoMeio);
    RealmObject.set(this, 'tipoProdutoId', tipoProdutoId);
    RealmObject.set(this, 'tipoProduto', tipoProduto);
    RealmObject.set(this, 'tipoTecnologiaId', tipoTecnologiaId);
    RealmObject.set(this, 'tipoTecnologiaDescricao', tipoTecnologiaDescricao);
    RealmObject.set(this, 'tipoTecnologiaIdTipoMeioAcesso', tipoTecnologiaIdTipoMeioAcesso);
    RealmObject.set(this, 'tipoTecnologiaIdTipoProduto', tipoTecnologiaIdTipoProduto);
    RealmObject.set(this, 'acessos', acessos);
    RealmObject.set(this, 'velocidade', velocidade);
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
  String get cnpj => RealmObject.get<String>(this, 'cnpj') as String;
  @override
  set cnpj(String value) => RealmObject.set(this, 'cnpj', value);

  @override
  String get ano => RealmObject.get<String>(this, 'ano') as String;
  @override
  set ano(String value) => RealmObject.set(this, 'ano', value);

  @override
  String get mes => RealmObject.get<String>(this, 'mes') as String;
  @override
  set mes(String value) => RealmObject.set(this, 'mes', value);

  @override
  String get codIbgeId => RealmObject.get<String>(this, 'codIbgeId') as String;
  @override
  set codIbgeId(String value) => RealmObject.set(this, 'codIbgeId', value);

  @override
  String get codIbgeDescricao => RealmObject.get<String>(this, 'codIbgeDescricao') as String;
  @override
  set codIbgeDescricao(String value) => RealmObject.set(this, 'codIbgeDescricao', value);

  @override
  String get codIbge => RealmObject.get<String>(this, 'codIbge') as String;
  @override
  set codIbge(String value) => RealmObject.set(this, 'codIbge', value);

  @override
  String get codIbgeIdUf => RealmObject.get<String>(this, 'codIbgeIdUf') as String;
  @override
  set codIbgeIdUf(String value) => RealmObject.set(this, 'codIbgeIdUf', value);

  @override
  String get tipoClienteId => RealmObject.get<String>(this, 'tipoClienteId') as String;
  @override
  set tipoClienteId(String value) => RealmObject.set(this, 'tipoClienteId', value);

  @override
  String get tipoCliente => RealmObject.get<String>(this, 'tipoCliente') as String;
  @override
  set tipoAtendimentoId(String value) => RealmObject.set(this, 'tipoAtendimentoId', value);

  @override
  String get tipoAtendimento => RealmObject.get<String>(this, 'tipoAtendimento') as String;
  @override
  set tipoAtendimento(String value) => RealmObject.set(this, 'tipoAtendimento', value);

  @override
  String get tipoMeioId => RealmObject.get<String>(this, 'tipoMeioId') as String;
  @override
  set tipoMeioId(String value) => RealmObject.set(this, 'tipoMeioId', value);

  @override
  String get tipoMeio => RealmObject.get<String>(this, 'tipoMeio') as String;
  @override
  set tipoMeio(String value) => RealmObject.set(this, 'tipoMeio', value);

  @override
  String get tipoProdutoId => RealmObject.get<String>(this, 'tipoProdutoId') as String;
  @override
  set tipoProdutoId(String value) => RealmObject.set(this, 'tipoProdutoId', value);

  @override
  String get tipoProduto => RealmObject.get<String>(this, 'tipoProduto') as String;
  @override
  set tipoProduto(String value) => RealmObject.set(this, 'tipoProduto', value);

  @override
  String get tipoTecnologiaId => RealmObject.get<String>(this, 'tipoTecnologiaId') as String;
  @override
  set tipoTecnologiaId(String value) => RealmObject.set(this, 'tipoTecnologiaId', value);

  @override
  String get tipoTecnologiaDescricao => RealmObject.get<String>(this, 'tipoTecnologiaDescricao') as String;
  @override
  set tipoTecnologiaDescricao(String value) => RealmObject.set(this, 'tipoTecnologiaDescricao', value);

  @override
  String get tipoTecnologiaIdTipoMeioAcesso => RealmObject.get<String>(this, 'tipoTecnologiaIdTipoMeioAcesso') as String;
  @override
  set tipoTecnologiaIdTipoMeioAcesso(String value) => RealmObject.set(this, 'tipoTecnologiaIdTipoMeioAcesso', value);

  @override
  String get tipoTecnologiaIdTipoProduto => RealmObject.get<String>(this, 'tipoTecnologiaIdTipoProduto') as String;
  @override
  set tipoTecnologiaIdTipoProduto(String value) => RealmObject.set(this, 'tipoTecnologiaIdTipoProduto', value);

  @override
  String get acessos => RealmObject.get<String>(this, 'acessos') as String;
  @override
  set acessos(String value) => RealmObject.set(this, 'acessos', value);

  @override
  String get velocidade => RealmObject.get<String>(this, 'velocidade') as String;
  @override
  set velocidade(String value) => RealmObject.set(this, 'velocidade', value);


  @override
  Stream<RealmObjectChanges<TbQuantitativeDistributionPhysicalAccessesService>> get changes => RealmObject.getChanges<TbQuantitativeDistributionPhysicalAccessesService>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbQuantitativeDistributionPhysicalAccessesService._);
    return const SchemaObject(TbQuantitativeDistributionPhysicalAccessesService, '_TbQuantitativeDistributionPhysicalAccessesService', [
      SchemaProperty('idApp', RealmPropertyType.objectid, mapTo: 'idApp', primaryKey: true),
      SchemaProperty('idFichaSiciApp', RealmPropertyType.string),
      SchemaProperty('cnpj', RealmPropertyType.string),
      SchemaProperty('ano', RealmPropertyType.string),
      SchemaProperty('mes', RealmPropertyType.string),
      SchemaProperty('codIbgeId', RealmPropertyType.string),
      SchemaProperty('codIbgeDescricao', RealmPropertyType.string),
      SchemaProperty('codIbge', RealmPropertyType.string),
      SchemaProperty('codIbgeIdUf', RealmPropertyType.string),
      SchemaProperty('tipoClienteId', RealmPropertyType.string),
      SchemaProperty('tipoCliente', RealmPropertyType.string),
      SchemaProperty('tipoAtendimentoId', RealmPropertyType.string),
      SchemaProperty('tipoAtendimento', RealmPropertyType.string),
      SchemaProperty('tipoMeioId', RealmPropertyType.string),
      SchemaProperty('tipoMeio', RealmPropertyType.string),
      SchemaProperty('tipoProdutoId', RealmPropertyType.string),
      SchemaProperty('tipoProduto', RealmPropertyType.string),
      SchemaProperty('tipoTecnologiaId', RealmPropertyType.string),
      SchemaProperty('tipoTecnologiaDescricao', RealmPropertyType.string),
      SchemaProperty('tipoTecnologiaIdTipoMeioAcesso', RealmPropertyType.string),
      SchemaProperty('tipoTecnologiaIdTipoProduto', RealmPropertyType.string),
      SchemaProperty('acessos', RealmPropertyType.string),
      SchemaProperty('velocidade', RealmPropertyType.string),
    ]);
  }
}
