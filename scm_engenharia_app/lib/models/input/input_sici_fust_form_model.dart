
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
    idFichaSiciApp = json['idFichaSiciApp'];
    idRegistro = json['idRegistro'].toString();
    idEmpresa = json['idEmpresa'].toString();
    id = json['id'].toString();
    idUsuarioCliente = json['id_usuario_cliente'].toString();
    idUsuarioConsultor = json['id_usuario_consultor'].toString();
    periodoReferencia = json['periodoReferencia'].toString();
    razaoSocial = json['razaoSocial'].toString();
    telefoneFixo = json['telefoneFixo'].toString();
    cnpj = json['cnpj'].toString();
    telefoneMovel = json['telefoneMovel'].toString();
    receitaBruta = json['receitaBruta'].toString();
    idFinanceiro = json['idFinanceiro'].toString();
    simples = json['simples'].toString();
    simplesPorc = json['simplesPorc'].toString();
    icms = json['icms'].toString();
    icmsPorc = json['icmsPorc'].toString();
    pis = json['pis'].toString();
    pisPorc = json['pisPorc'].toString();
    cofins = json['cofins'].toString();
    cofinsPorc = json['cofinsPorc'].toString();
    receitaLiquida = json['receitaLiquida'].toString();
    observacoes = json['observacoes'].toString();
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