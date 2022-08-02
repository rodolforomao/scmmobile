

class EnvironmentVariables {
  List<CodIbge>? codIbge;
  List<Uf>? uf;
  List<CustomerType>? tipoCliente;
  List<ServiceType>? tipoAtendimento;
  List<MediumAccessType>? tipoMeioAcesso;
  List<TechnologyType>? tipoTecnologia;
  List<ProductType>? tipoProduto;

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
      tipoCliente = <CustomerType>[];
      json['TipoCliente'].forEach((v) {
        tipoCliente!.add(new CustomerType.fromJson(v));
      });
    }
    if (json['TipoAtendimento'] != null) {
      tipoAtendimento = <ServiceType>[];
      json['TipoAtendimento'].forEach((v) {
        tipoAtendimento!.add(new ServiceType.fromJson(v));
      });
    }
    if (json['TipoMeioAcesso'] != null) {
      tipoMeioAcesso = <MediumAccessType>[];
      json['TipoMeioAcesso'].forEach((v) {
        tipoMeioAcesso!.add(new MediumAccessType.fromJson(v));
      });
    }
    if (json['TipoTecnologia'] != null) {
      tipoTecnologia = <TechnologyType>[];
      json['TipoTecnologia'].forEach((v) {
        tipoTecnologia!.add(new TechnologyType.fromJson(v));
      });
    }
    if (json['TipoProduto'] != null) {
      tipoProduto = <ProductType>[];
      json['TipoProduto'].forEach((v) {
        tipoProduto!.add(new ProductType.fromJson(v));
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

class CustomerType {
  String? id;
  String? descricao;

  CustomerType({this.id, this.descricao});

  CustomerType.fromJson(Map<String, dynamic> json) {
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

class ServiceType {
  String? id;
  String? descricao;

  ServiceType(
      {this.id, this.descricao});

  ServiceType.fromJson(Map<String, dynamic> json) {
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

class MediumAccessType {
  String? id;
  String? descricao;

  MediumAccessType(
      {this.id, this.descricao});

  MediumAccessType.fromJson(Map<String, dynamic> json) {
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

class TechnologyType {
  String? id;
  String? descricao;
  String? idTipoMeioAcesso;
  String? idTipoProduto;

  TechnologyType(
      {this.id, this.descricao, this.idTipoMeioAcesso, this.idTipoProduto});

  TechnologyType.fromJson(Map<String, dynamic> json) {
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

class ProductType {
  String? id;
  String? descricao;

  ProductType(
      {this.id, this.descricao});

  ProductType.fromJson(Map<String, dynamic> json) {
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