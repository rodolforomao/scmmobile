class TbUsuario {
  int? idUsuarioApp;
  String? idUsuario;
  String? idPerfil;
  String? nome;
  String? senha;
  String? email;
  String? telefone;
  String? dtUltacesso;
  String? empresa;
  String? periodoReferencia;
  String? cpf;

  TbUsuario(
      {
        this.idUsuarioApp = 0,
        this.idUsuario = "",
        this.idPerfil = "",
        this.nome = "",
        this.senha = "",
        this.email = "",
        this.telefone = "",
        this.dtUltacesso = "",
        this.empresa = "",
        this.periodoReferencia = "",
        this.cpf = "",
      });

  TbUsuario.fromJson(Map<String, dynamic> json) {

    idUsuarioApp = json['idUsuarioApp'];
    idUsuario = json['idUsuario'];
    idPerfil = json['idPerfil'];
    nome = json['nome'];
    senha = json['senha'];
    email = json['email'];
    telefone = json['telefone'];
    dtUltacesso = json['dtUltacesso'];
    empresa = json['empresa'];
    periodoReferencia = json['periodoReferencia'];
    cpf = json['cpf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUsuarioApp'] = this.idUsuarioApp;
    data['idUsuario'] = this.idUsuario;
    data['idPerfil'] = this.idPerfil;
    data['nome'] = this.nome;
    data['senha'] = this.senha;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['dtUltacesso'] = this.dtUltacesso;
    data['empresa'] = this.empresa;
    data['periodoReferencia'] = this.periodoReferencia;
    data['cpf'] = this.cpf;
    return data;
  }
}