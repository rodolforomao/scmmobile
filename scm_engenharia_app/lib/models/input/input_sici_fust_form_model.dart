
import '../../help/components.dart';

class InputSiciFileModel {
  String? idFichaSiciApp;
  String? idRegistro;
  String? idEmpresa;
  String? idUsuarioCliente;
  String? idUsuarioConsultor;
  String? id;
  String? periodoReferencia;
  String? razaoSocial;
  String? telefoneFixo;
  String? cnpj;
  String? telefoneMovel;
  String? receitaBruta;
  String? idFinanceiro;
  String? simples;
  String? simplesPorc;
  String? icms;
  String? icmsPorc;
  String? pis;
  String? pisPorc;
  String? cofins;
  String? cofinsPorc;
  String? receitaLiquida;
  String? observacoes;
  List<InputDadosEmServicosModel>? dadosEmServicos;
  InputSiciFileModel({
    this.idFichaSiciApp = '',
    this.idRegistro,
    this.idEmpresa,
    this.id,
    this.idUsuarioCliente,
    this.idUsuarioConsultor,
    this.periodoReferencia,
    this.razaoSocial,
    this.telefoneFixo,
    this.cnpj,
    this.telefoneMovel,
    this.receitaBruta,
    this.idFinanceiro,
    this.simples,
    this.simplesPorc,
    this.icms,
    this.icmsPorc,
    this.pis,
    this.pisPorc,
    this.cofins,
    this.cofinsPorc,
    this.receitaLiquida,
    this.observacoes,
    this.dadosEmServicos
  });

  InputSiciFileModel.fromJson(Map<String, dynamic> json) {
    idFichaSiciApp = Components.onIsEmpty(json['idFichaSiciApp']);
    idRegistro = Components.onIsEmpty(json['idRegistro']);
    idEmpresa = Components.onIsEmpty(json['idEmpresa']);
    id =  Components.onIsEmpty(json['id']);
    idUsuarioCliente = Components.onIsEmpty(json['id_usuario_cliente']);
    idUsuarioConsultor = Components.onIsEmpty(json['id_usuario_consultor']);
    periodoReferencia = Components.onIsEmpty(json['periodoReferencia']);
    razaoSocial = Components.onIsEmpty(json['razaoSocial']);
    telefoneFixo = Components.onIsEmpty(json['telefoneFixo']);
    cnpj = Components.onIsEmpty(json['cnpj']);
    telefoneMovel = Components.onIsEmpty(json['telefoneMovel']);
    receitaBruta = Components.onIsEmpty(json['receitaBruta']);
    idFinanceiro = Components.onIsEmpty(json['idFinanceiro']);
    simples = Components.onIsEmpty(json['simples']);
    simplesPorc = Components.onIsEmpty(json['simplesPorc']);
    icms = Components.onIsEmpty(json['icms']);
    icmsPorc = Components.onIsEmpty(json['icmsPorc']);
    pis = Components.onIsEmpty(json['pis']);
    pisPorc = Components.onIsEmpty(json['pisPorc']);
    cofins = Components.onIsEmpty(json['cofins']);
    cofinsPorc = Components.onIsEmpty(json['cofinsPorc']);
    receitaLiquida = Components.onIsEmpty(json['receitaLiquida']);
    observacoes = Components.onIsEmpty(json['observacoes']);
    if (json['dadosEmServicos'] != null) {
      dadosEmServicos = <InputDadosEmServicosModel>[];
      json['dadosEmServicos'].forEach((v) {
        dadosEmServicos!.add(InputDadosEmServicosModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idFichaSiciApp'] = idFichaSiciApp  ?? '';
    data['idRegistro'] = idRegistro  ?? '';
    data['idEmpresa'] = idEmpresa  ?? '';
    data['id'] = id ?? '';
    data['idUsuarioCliente'] = idUsuarioCliente ?? '';
    data['idUsuarioConsultor'] = idUsuarioConsultor ?? '';
    data['periodoReferencia'] = periodoReferencia ?? '';
    data['razaoSocial'] = razaoSocial ?? '';
    data['telefoneFixo'] = telefoneFixo ?? '';
    data['cnpj'] = cnpj  ?? '';
    data['telefoneMovel'] = telefoneMovel ?? '';
    data['receitaBruta'] = receitaBruta  ?? '';
    data['idFinanceiro'] = idFinanceiro  ?? '';
    data['simples'] = simples  ?? '';
    data['simplesPorc'] = simplesPorc  ?? '';
    data['icms'] = icms  ?? '';
    data['icmsPorc'] = icmsPorc  ?? '';
    data['pis'] = pis  ?? '';
    data['pisPorc'] = pisPorc  ?? '';
    data['cofins'] = cofins  ?? '';
    data['cofinsPorc'] = cofinsPorc  ?? '';
    data['receitaLiquida'] = receitaLiquida  ?? '';
    data['observacoes'] = observacoes  ?? '';
    if (this.dadosEmServicos != null) {
      data['dadosEmServicos'] =
          this.dadosEmServicos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InputDadosEmServicosModel {
  String? idLancamento;
  String? idSiciFile;
  String? codIbge;
  String? uf;
  String? tipoCliente;
  String? tipoAtendimento;
  String? tipoAcesso;
  String? tecnologia;
  String? tipoProduto;
  String? velocidade;
  String? quantidadeAcesso;

  InputDadosEmServicosModel(
      {
        this.idLancamento,
        this.idSiciFile,
        this.codIbge,
        this.uf,
        this.tipoCliente,
        this.tipoAtendimento,
        this.tipoAcesso,
        this.tecnologia,
        this.tipoProduto,
        this.velocidade,
        this.quantidadeAcesso});

  InputDadosEmServicosModel.fromJson(Map<String, dynamic> json) {
    idLancamento = json['idLancamento'];
    idSiciFile = json['idSiciFile'];
    codIbge = json['codIbge'];
    uf = json['uf'];
    tipoCliente = json['tipoCliente'];
    tipoAtendimento = json['tipoAtendimento'];
    tipoAcesso = json['tipoAcesso'];
    tecnologia = json['tecnologia'];
    tipoProduto = json['tipoProduto'];
    velocidade = json['velocidade'];
    quantidadeAcesso = json['quantidadeAcesso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLancamento'] = idLancamento;
    data['idSiciFile'] = idSiciFile;
    data['codIbge'] = codIbge;
    data['uf'] = uf;
    data['tipoCliente'] = tipoCliente;
    data['tipoAtendimento'] = tipoAtendimento;
    data['tipoAcesso'] = tipoAcesso;
    data['tecnologia'] = tecnologia;
    data['tipoProduto'] = tipoProduto;
    data['velocidade'] = velocidade;
    data['quantidadeAcesso'] = quantidadeAcesso;
    return data;
  }
}