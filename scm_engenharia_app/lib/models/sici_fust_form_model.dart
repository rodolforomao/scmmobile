class SiciFustFormModel {
  String? id;
  String? idEmpresa;
  String? idUsuarioCliente;
  String? idUsuarioConsultor;
  String? periodoReferencia;
  String? ultimaAlteracao;
  String? idUsuarioUltimaAlteracao;
  String? status;
  String? razaoSocial;
  String? cnpj;
  String? telefoneFixo;
  String? telefoneMovel;
  String? emailEmpresa;
  String? receitaBruta;
  String? receitaLiquida;
  String? simples;
  String? simplesPorc;
  String? icms;
  String? icmsPorc;
  String? pis;
  String? pisPorc;
  String? cofins;
  String? cofinsPorc;
  String? observacoes;
  String? idLancamento;
  String? idUsuario;
  String? iDPERFIL;
  String? cODISENHA;
  String? dESCNOME;
  String? dATAULTIMOACESSO;
  String? eMAIL;
  String? tELEFONE;
  String? fLAGALTERASENHA;
  String? idUsuarioAlteracao;
  String? fLAGPRIMEIROACESSO;
  String? cpf;
  String? empresa;
  String? idUf;
  String? aprovado;
  Null? tELEFONEWHATSAPP;
  String? codValidacao;
  String? validacaoEmail;
  String? excluido;
  String? bloqueado;
  String? idEstado;
  String? descricao;
  String? idProximo;
  String? nomeCliente;
  String? nomeConsultor;
  String? envioLancamento;
  String? estado;
  List<DadosEmServicos>? dadosEmServicos;

  SiciFustFormModel(
      {this.id,
        this.idEmpresa,
        this.idUsuarioCliente,
        this.idUsuarioConsultor,
        this.periodoReferencia,
        this.ultimaAlteracao,
        this.idUsuarioUltimaAlteracao,
        this.status,
        this.razaoSocial,
        this.cnpj,
        this.telefoneFixo,
        this.telefoneMovel,
        this.emailEmpresa,
        this.receitaBruta,
        this.receitaLiquida,
        this.simples,
        this.simplesPorc,
        this.icms,
        this.icmsPorc,
        this.pis,
        this.pisPorc,
        this.cofins,
        this.cofinsPorc,
        this.observacoes,
        this.idLancamento,
        this.idUsuario,
        this.iDPERFIL,
        this.cODISENHA,
        this.dESCNOME,
        this.dATAULTIMOACESSO,
        this.eMAIL,
        this.tELEFONE,
        this.fLAGALTERASENHA,
        this.idUsuarioAlteracao,
        this.fLAGPRIMEIROACESSO,
        this.cpf,
        this.empresa,
        this.idUf,
        this.aprovado,
        this.tELEFONEWHATSAPP,
        this.codValidacao,
        this.validacaoEmail,
        this.excluido,
        this.bloqueado,
        this.idEstado,
        this.descricao,
        this.idProximo,
        this.nomeCliente,
        this.nomeConsultor,
        this.envioLancamento,
        this.estado,
        this.dadosEmServicos});

  SiciFustFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idEmpresa = json['id_empresa'];
    idUsuarioCliente = json['id_usuario_cliente'];
    idUsuarioConsultor = json['id_usuario_consultor'];
    periodoReferencia = json['periodo_referencia'];
    ultimaAlteracao = json['ultima_alteracao'];
    idUsuarioUltimaAlteracao = json['id_usuario_ultima_alteracao'];
    status = json['status'];
    razaoSocial = json['razao_social'];
    cnpj = json['cnpj'];
    telefoneFixo = json['telefone_fixo'];
    telefoneMovel = json['telefone_movel'];
    emailEmpresa = json['email_empresa'];
    receitaBruta = json['receita_bruta'];
    receitaLiquida = json['receita_liquida'];
    simples = json['simples'];
    simplesPorc = json['simplesPorc'];
    icms = json['icms'];
    icmsPorc = json['icmsPorc'];
    pis = json['pis'];
    pisPorc = json['pisPorc'];
    cofins = json['cofins'];
    cofinsPorc = json['cofinsPorc'];
    observacoes = json['observacoes'];
    idLancamento = json['id_lancamento'];
    idUsuario = json['id_usuario'];
    iDPERFIL = json['ID_PERFIL'];
    cODISENHA = json['CODI_SENHA'];
    dESCNOME = json['DESC_NOME'];
    dATAULTIMOACESSO = json['DATA_ULTIMOACESSO'];
    eMAIL = json['EMAIL'];
    tELEFONE = json['TELEFONE'];
    fLAGALTERASENHA = json['FLAG_ALTERASENHA'];
    idUsuarioAlteracao = json['id_usuario_alteracao'];
    fLAGPRIMEIROACESSO = json['FLAG_PRIMEIRO_ACESSO'];
    cpf = json['cpf'];
    empresa = json['empresa'];
    idUf = json['id_uf'];
    aprovado = json['aprovado'];
    tELEFONEWHATSAPP = json['TELEFONE_WHATSAPP'];
    codValidacao = json['cod_validacao'];
    validacaoEmail = json['validacao_email'];
    excluido = json['excluido'];
    bloqueado = json['bloqueado'];
    idEstado = json['id_estado'];
    descricao = json['descricao'];
    idProximo = json['id_proximo'];
    nomeCliente = json['nome_cliente'];
    nomeConsultor = json['nome_consultor'];
    envioLancamento = json['envio_lancamento'];
    estado = json['estado'];
    if (json['dadosEmServicos'] != null) {
      dadosEmServicos = <DadosEmServicos>[];
      json['dadosEmServicos'].forEach((v) {
        dadosEmServicos!.add(new DadosEmServicos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_empresa'] = this.idEmpresa;
    data['id_usuario_cliente'] = this.idUsuarioCliente;
    data['id_usuario_consultor'] = this.idUsuarioConsultor;
    data['periodo_referencia'] = this.periodoReferencia;
    data['ultima_alteracao'] = this.ultimaAlteracao;
    data['id_usuario_ultima_alteracao'] = this.idUsuarioUltimaAlteracao;
    data['status'] = this.status;
    data['razao_social'] = this.razaoSocial;
    data['cnpj'] = this.cnpj;
    data['telefone_fixo'] = this.telefoneFixo;
    data['telefone_movel'] = this.telefoneMovel;
    data['email_empresa'] = this.emailEmpresa;
    data['receita_bruta'] = this.receitaBruta;
    data['receita_liquida'] = this.receitaLiquida;
    data['simples'] = this.simples;
    data['simplesPorc'] = this.simplesPorc;
    data['icms'] = this.icms;
    data['icmsPorc'] = this.icmsPorc;
    data['pis'] = this.pis;
    data['pisPorc'] = this.pisPorc;
    data['cofins'] = this.cofins;
    data['cofinsPorc'] = this.cofinsPorc;
    data['observacoes'] = this.observacoes;
    data['id_lancamento'] = this.idLancamento;
    data['id_usuario'] = this.idUsuario;
    data['ID_PERFIL'] = this.iDPERFIL;
    data['CODI_SENHA'] = this.cODISENHA;
    data['DESC_NOME'] = this.dESCNOME;
    data['DATA_ULTIMOACESSO'] = this.dATAULTIMOACESSO;
    data['EMAIL'] = this.eMAIL;
    data['TELEFONE'] = this.tELEFONE;
    data['FLAG_ALTERASENHA'] = this.fLAGALTERASENHA;
    data['id_usuario_alteracao'] = this.idUsuarioAlteracao;
    data['FLAG_PRIMEIRO_ACESSO'] = this.fLAGPRIMEIROACESSO;
    data['cpf'] = this.cpf;
    data['empresa'] = this.empresa;
    data['id_uf'] = this.idUf;
    data['aprovado'] = this.aprovado;
    data['TELEFONE_WHATSAPP'] = this.tELEFONEWHATSAPP;
    data['cod_validacao'] = this.codValidacao;
    data['validacao_email'] = this.validacaoEmail;
    data['excluido'] = this.excluido;
    data['bloqueado'] = this.bloqueado;
    data['id_estado'] = this.idEstado;
    data['descricao'] = this.descricao;
    data['id_proximo'] = this.idProximo;
    data['nome_cliente'] = this.nomeCliente;
    data['nome_consultor'] = this.nomeConsultor;
    data['envio_lancamento'] = this.envioLancamento;
    data['estado'] = this.estado;
    if (this.dadosEmServicos != null) {
      data['dadosEmServicos'] =
          this.dadosEmServicos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DadosEmServicos {
  String? idLancamento;
  String? codIbge;
  String? uf;
  String? tipoCliente;
  String? tipoAtendimento;
  String? tipoAcesso;
  String? tecnologia;
  String? tipoProduto;
  String? velocidade;
  String? quantidadeAcesso;

  DadosEmServicos(
      {this.idLancamento,
        this.codIbge,
        this.uf,
        this.tipoCliente,
        this.tipoAtendimento,
        this.tipoAcesso,
        this.tecnologia,
        this.tipoProduto,
        this.velocidade,
        this.quantidadeAcesso});

  DadosEmServicos.fromJson(Map<String, dynamic> json) {
    idLancamento = json['id_lancamento'];
    codIbge = json['cod_ibge'];
    uf = json['uf'];
    tipoCliente = json['tipo_cliente'];
    tipoAtendimento = json['tipo_atendimento'];
    tipoAcesso = json['tipo_acesso'];
    tecnologia = json['tecnologia'];
    tipoProduto = json['tipo_produto'];
    velocidade = json['velocidade'];
    quantidadeAcesso = json['quantidade_acesso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_lancamento'] = this.idLancamento;
    data['cod_ibge'] = this.codIbge;
    data['uf'] = this.uf;
    data['tipo_cliente'] = this.tipoCliente;
    data['tipo_atendimento'] = this.tipoAtendimento;
    data['tipo_acesso'] = this.tipoAcesso;
    data['tecnologia'] = this.tecnologia;
    data['tipo_produto'] = this.tipoProduto;
    data['velocidade'] = this.velocidade;
    data['quantidade_acesso'] = this.quantidadeAcesso;
    return data;
  }
}







