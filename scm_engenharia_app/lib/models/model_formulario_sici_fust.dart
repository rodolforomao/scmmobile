class ModelFormularioSiciFustJson {
  String id;
  String idEmpresa;
  String idUsuarioCliente;
  String idUsuarioConsultor;
  String periodoReferencia;

  String razaoSocial;
  String cnpj;
  String telefoneFixo;
  String telefoneMovel;
  String emailEmpresa;
  String receitaBruta;
  String receitaLiquida;
  String simples;
  String simplesPorc;
  String icms;
  String icmsPorc;
  String pis;
  String pisPorc;
  String cofins;
  String cofinsPorc;
  String observacoes;
  String idLancamento;
  String idUsuario;
  String iDPERFIL;
  String cODISENHA;
  String dESCNOME;
  String dATAULTIMOACESSO;
  String eMAIL;
  String tELEFONE;
  String fLAGALTERASENHA;
  String idUsuarioAlteracao;
  String fLAGPRIMEIROACESSO;
  String cpf;
  String empresa;
  String idUf;
  String aprovado;
  String tELEFONEWHATSAPP;
  String codValidacao;
  String validacaoEmail;
  String excluido;
  String bloqueado;
  String idEstado;
  String estado;
  String passo;
  String estadoRobo;
  String nomeCliente;
  String nomeConsultor;

  String emailConsutor;
  String emailCliente;
  String mesReferencia;

  String envioLancamento;
  List<ModelDistribuicaoFisicosServicoQuantitativoJson> distribuicaoFisicosServicoQuantitativo;

  ModelFormularioSiciFustJson(
      { this.id,
        this.idEmpresa,
        this.idUsuarioCliente,
        this.idUsuarioConsultor,
        this.periodoReferencia,
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
        this.estado,
        this.passo,
        this.estadoRobo,
        this.nomeCliente,
        this.nomeConsultor,
        this.envioLancamento,
        this.emailConsutor,
        this.emailCliente,
        this.mesReferencia,
        this.distribuicaoFisicosServicoQuantitativo});

  ModelFormularioSiciFustJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idEmpresa = json['id_empresa'];
    idUsuarioCliente = json['id_usuario_cliente'];
    idUsuarioConsultor = json['id_usuario_consultor'];
    periodoReferencia = json['periodo_referencia'];
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
    estado = json['estado'];
    passo = json['passo'];
    estadoRobo = json['estado_robo'];
    nomeCliente = json['nome_cliente'];
    nomeConsultor = json['nome_consultor'];
    envioLancamento = json['envio_lancamento'];

    emailConsutor = json['mes_referencia'];
    emailCliente = json['email_cliente'];
    mesReferencia = json['mes_referencia'];

    if (json['dadosEmServicos'] != null) {
      distribuicaoFisicosServicoQuantitativo = new List<ModelDistribuicaoFisicosServicoQuantitativoJson>();
      json['dadosEmServicos'].forEach((v) {
        distribuicaoFisicosServicoQuantitativo.add(new ModelDistribuicaoFisicosServicoQuantitativoJson.fromJson(v));
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
    data['estado'] = this.estado;
    data['passo'] = this.passo;
    data['estado_robo'] = this.estadoRobo;
    data['nome_cliente'] = this.nomeCliente;
    data['nome_consultor'] = this.nomeConsultor;
    data['envio_lancamento'] = this.envioLancamento;

    data['mes_referencia'] = this.emailConsutor;
    data['email_cliente'] = this.emailCliente;
    data['mes_referencia'] = this.mesReferencia;


    if (this.distribuicaoFisicosServicoQuantitativo != null) {
      data['dadosEmServicos'] =
          this.distribuicaoFisicosServicoQuantitativo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ModelDistribuicaoFisicosServicoQuantitativoJson {
  String id;
  String codIbge;
  String idUf;
  String idMunicipio;
  String idTecnologia;
  String pf0;
  String pf512;
  String pf2;
  String pf12;
  String pf34;
  String pj0;
  String pj512;
  String pj2;
  String pj12;
  String pj34;
  String idLancamento;
  String ultimaAlteracao;
  String idUsuarioUltimaAlteracao;
  String municipio;
  String uf;
  String tecnologia;

  ModelDistribuicaoFisicosServicoQuantitativoJson(
      {this.id,
        this.codIbge,
        this.idUf,
        this.idMunicipio,
        this.idTecnologia,
        this.pf0,
        this.pf512,
        this.pf2,
        this.pf12,
        this.pf34,
        this.pj0,
        this.pj512,
        this.pj2,
        this.pj12,
        this.pj34,
        this.idLancamento,
        this.ultimaAlteracao,
        this.idUsuarioUltimaAlteracao,
        this.municipio,
        this.uf,
        this.tecnologia});

  ModelDistribuicaoFisicosServicoQuantitativoJson.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    codIbge = json['cod_ibge'];
    idUf = json['id_uf'];
    idMunicipio = json['id_municipio'];
    idTecnologia = json['id_tecnologia'];
    pf0 = json['pf_0'];
    pf512 = json['pf_512'];
    pf2 = json['pf_2'];
    pf12 = json['pf_12'];
    pf34 = json['pf_34'];
    pj0 = json['pj_0'];
    pj512 = json['pj_512'];
    pj2 = json['pj_2'];
    pj12 = json['pj_12'];
    pj34 = json['pj_34'];
    idLancamento = json['id_lancamento'];
    ultimaAlteracao = json['ultima_alteracao'];
    idUsuarioUltimaAlteracao = json['id_usuario_ultima_alteracao'];
    municipio = json['municipio'];
    uf = json['uf'];
    tecnologia = json['tecnologia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cod_ibge'] = this.codIbge;
    data['id_uf'] = this.idUf;
    data['id_municipio'] = this.idMunicipio;
    data['id_tecnologia'] = this.idTecnologia;
    data['pf_0'] = this.pf0;
    data['pf_512'] = this.pf512;
    data['pf_2'] = this.pf2;
    data['pf_12'] = this.pf12;
    data['pf_34'] = this.pf34;
    data['pj_0'] = this.pj0;
    data['pj_512'] = this.pj512;
    data['pj_2'] = this.pj2;
    data['pj_12'] = this.pj12;
    data['pj_34'] = this.pj34;
    data['id_lancamento'] = this.idLancamento;
    data['ultima_alteracao'] = this.ultimaAlteracao;
    data['id_usuario_ultima_alteracao'] = this.idUsuarioUltimaAlteracao;
    data['municipio'] = this.municipio;
    data['uf'] = this.uf;
    data['tecnologia'] = this.tecnologia;
    return data;
  }
}



