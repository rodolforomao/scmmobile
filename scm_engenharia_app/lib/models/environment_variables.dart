


class EnvironmentVariables {
  List<CodIbge>? codIbge;
  List<Uf>? uf;
  List<TipoCliente>? tipoCliente;
  List<TipoAtendimento>? tipoAtendimento;
  List<TipoMeioAcesso>? tipoMeioAcesso;
  List<TipoTecnologia>? tipoTecnologia;
  List<TipoProduto>? tipoProduto;

  EnvironmentVariables(
      {this.codIbge,
        this.uf,
        this.tipoCliente,
        this.tipoAtendimento,
        this.tipoMeioAcesso,
        this.tipoTecnologia,
        this.tipoProduto});

  EnvironmentVariables.fromJson(Map<String, dynamic> json) {
    if (json['CodIbge'] != null) {
      codIbge = <CodIbge>[];
      json['CodIbge'].forEach((v) {
        codIbge!.add(new CodIbge.fromJson(v));
      });
    }
    if (json['Uf'] != null) {
      uf = <Uf>[];
      json['Uf'].forEach((v) {
        uf!.add(new Uf.fromJson(v));
      });
    }
    if (json['TipoCliente'] != null) {
      tipoCliente = <TipoCliente>[];
      json['TipoCliente'].forEach((v) {
        tipoCliente!.add(new TipoCliente.fromJson(v));
      });
    }
    if (json['TipoAtendimento'] != null) {
      tipoAtendimento = <TipoAtendimento>[];
      json['TipoAtendimento'].forEach((v) {
        tipoAtendimento!.add(new TipoAtendimento.fromJson(v));
      });
    }
    if (json['TipoMeioAcesso'] != null) {
      tipoMeioAcesso = <TipoMeioAcesso>[];
      json['TipoMeioAcesso'].forEach((v) {
        tipoMeioAcesso!.add(new TipoMeioAcesso.fromJson(v));
      });
    }
    if (json['TipoTecnologia'] != null) {
      tipoTecnologia = <TipoTecnologia>[];
      json['TipoTecnologia'].forEach((v) {
        tipoTecnologia!.add(new TipoTecnologia.fromJson(v));
      });
    }
    if (json['TipoProduto'] != null) {
      tipoProduto = <TipoProduto>[];
      json['TipoProduto'].forEach((v) {
        tipoProduto!.add(new TipoProduto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.codIbge != null) {
      data['CodIbge'] = this.codIbge!.map((v) => v.toJson()).toList();
    }
    if (this.uf != null) {
      data['Uf'] = this.uf!.map((v) => v.toJson()).toList();
    }
    if (this.tipoCliente != null) {
      data['TipoCliente'] = this.tipoCliente!.map((v) => v.toJson()).toList();
    }
    if (this.tipoAtendimento != null) {
      data['TipoAtendimento'] =
          this.tipoAtendimento!.map((v) => v.toJson()).toList();
    }
    if (this.tipoMeioAcesso != null) {
      data['TipoMeioAcesso'] =
          this.tipoMeioAcesso!.map((v) => v.toJson()).toList();
    }
    if (this.tipoTecnologia != null) {
      data['TipoTecnologia'] =
          this.tipoTecnologia!.map((v) => v.toJson()).toList();
    }
    if (this.tipoProduto != null) {
      data['TipoProduto'] = this.tipoProduto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CodIbge {
  String? id;
  String? descricao;
  String? codIbge;
  String? idUf;

  CodIbge({this.id, this.descricao, this.codIbge, this.idUf});

  CodIbge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    codIbge = json['cod_ibge'];
    idUf = json['id_uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['cod_ibge'] = this.codIbge;
    data['id_uf'] = this.idUf;
    return data;
  }
}

class Uf {
  String? id;
  String? uf;

  Uf({this.id, this.uf});

  Uf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uf'] = this.uf;
    return data;
  }
}

class TipoAtendimento {
  String? id;
  String? descricao;

  TipoAtendimento({this.id, this.descricao});

  TipoAtendimento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }
}

class TipoCliente {
  String? id;
  String? descricao;

  TipoCliente({this.id, this.descricao});

  TipoCliente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }
}

class TipoMeioAcesso {
  String? id;
  String? descricao;

  TipoMeioAcesso({this.id, this.descricao});

  TipoMeioAcesso.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }
}

class TipoTecnologia {
  String? id;
  String? descricao;
  String? idTipoMeioAcesso;
  String? idTipoProduto;

  TipoTecnologia(
      {this.id, this.descricao, this.idTipoMeioAcesso, this.idTipoProduto});

  TipoTecnologia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    idTipoMeioAcesso = json['id_tipo_meio_acesso'];
    idTipoProduto = json['id_tipo_produto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['id_tipo_meio_acesso'] = this.idTipoMeioAcesso;
    data['id_tipo_produto'] = this.idTipoProduto;
    return data;
  }
}

class TipoProduto {
  String? id;
  String? descricao;

  TipoProduto({this.id, this.descricao});

  TipoProduto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }
}