class UserResponseModel {
  String? descNome;
  String? idPerfil;
  String? email;
  String? idUsuario;
  String? dtUltacesso;
  String? empresa;
  String? periodoReferencia;
  String? idContrato;
  String? telefoneConsultor;
  String? cpf;
  String? uf;

  UserResponseModel(
      {this.descNome,
        this.idPerfil,
        this.email,
        this.idUsuario,
        this.dtUltacesso,
        this.empresa,
        this.periodoReferencia,
        this.idContrato,
        this.telefoneConsultor,
        this.cpf,
        this.uf});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    descNome = json['desc_nome'] ?? 'Não informado';
    idPerfil = json['id_perfil']  ?? '0';
    email = json['email']  ?? 'Não informado';
    idUsuario = json['id_usuario']  ?? '0';
    dtUltacesso = json['dt_Ultacesso']?? DateTime.now().toString();
    empresa = json['empresa']  ?? 'Não informado';
    periodoReferencia = json['periodo_referencia'] ?? DateTime.now().toString();
    idContrato = json['idContrato'] ?? '0';
    telefoneConsultor = json['telefoneConsultor'] ?? '(00) 0 000-000';
    cpf = json['cpf']  ?? '00000000000';
    uf = json['uf']  ?? 'DF';
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
    data['uf'] = this.uf;
    return data;
  }
}