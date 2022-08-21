import 'package:realm/realm.dart';
part 'tb_quantitative_distribution_physical_accesses_service.g.dart';


@RealmModel()
class _TbQuantitativeDistributionPhysicalAccessesService {
  @PrimaryKey()
  @MapTo('idApp')
  late ObjectId idApp;
  late String idFichaSiciApp;
  late String cnpj;
  late String ano;
  late String mes;

  late String codIbgeId;
  late String codIbgeDescricao;
  late String codIbge;
  late String codIbgeIdUf;

  late String tipoClienteId;
  late String tipoCliente;

  late String tipoAtendimentoId;
  late String tipoAtendimento;

  late String tipoMeioId;
  late String tipoMeio;

  late String tipoProdutoId;
  late String tipoProduto;

  late String tipoTecnologiaId;
  late String tipoTecnologiaDescricao;
  late String tipoTecnologiaIdTipoMeioAcesso;
  late String tipoTecnologiaIdTipoProduto;

  late String acessos;
  late String velocidade;
}
