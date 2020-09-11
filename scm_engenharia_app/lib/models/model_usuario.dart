class ModelLoginJson {
  String usuario;
  String password;

  ModelLoginJson({
    this.usuario,
    this.password,
  });

  ModelLoginJson.fromJson(Map<String, dynamic> json) {
    usuario = json['user'];
    password = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.usuario;
    data['pass'] = this.password;
    return data;
  }
}

class ModelDadosUsuarioJson {
  String nome;
  String cpf;
  String email;
  String telefone;
  String telefoneWhatsapp;
  String empresa;
  String uf;
  ModelDadosUsuarioJson({
    this.nome,
    this.cpf,
    this.email,
    this.telefone,
    this.telefoneWhatsapp,
    this.empresa,
    this.uf,
  });

  ModelDadosUsuarioJson.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    telefone = json['telefone'];
    telefoneWhatsapp = json['telefoneWhatsapp'];
    empresa = json['empresa'];
    uf = json['uf'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['telefoneWhatsapp'] = this.telefoneWhatsapp;
    data['empresa'] = this.empresa;
    data['uf'] = this.uf;
    return data;
  }
}

class ModelInformacaoUsuario {
  String descNome;
  String idPerfil;
  String email;
  String idUsuario;
  String dtUltacesso;
  String empresa;
  String periodoReferencia;
  String idContrato;
  String telefoneConsultor;
  String cpf;

  ModelInformacaoUsuario(
      {this.descNome,
        this.idPerfil,
        this.email,
        this.idUsuario,
        this.dtUltacesso,
        this.empresa,
        this.periodoReferencia,
        this.idContrato,
        this.telefoneConsultor,
        this.cpf});

  ModelInformacaoUsuario.fromJson(Map<String, dynamic> json) {
    descNome = json['desc_nome'];
    idPerfil = json['id_perfil'];
    email = json['email'];
    idUsuario = json['id_usuario'];
    dtUltacesso = json['dt_Ultacesso'];
    empresa = json['empresa'];
    periodoReferencia = json['periodo_referencia'];
    idContrato = json['idContrato'];
    telefoneConsultor = json['telefoneConsultor'];
    cpf = json['cpf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc_nome'] = this.descNome;
    data['id_perfil'] = this.idPerfil;
    data['email'] = this.email;
    data['id_usuario'] = this.idUsuario;
    data['dt_Ultacesso'] = this.dtUltacesso;
    data['empresa'] = this.empresa;
    data['periodo_referencia'] = this.periodoReferencia;
    data['idContrato'] = this.idContrato;
    data['telefoneConsultor'] = this.telefoneConsultor;
    data['cpf'] = this.cpf;
    return data;
  }
}