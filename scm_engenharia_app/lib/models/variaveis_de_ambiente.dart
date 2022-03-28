class VariaveisDeAmbiente {
  late bool? status;
  String? mensagem;
  VariaveisDeAmbienteResultado? resultado;

  VariaveisDeAmbiente({this.status, this.mensagem, this.resultado});

  VariaveisDeAmbiente.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mensagem = json['mensagem'];
    resultado = json['resultado'] != null
        ? new VariaveisDeAmbienteResultado.fromJson(json['resultado'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['mensagem'] = this.mensagem;
    if (this.resultado != null) {
      data['resultado'] = this.resultado!.toJson();
    }
    return data;
  }
}

class VariaveisDeAmbienteResultado {
  List<UFMunicipios>? uFMunicipios;
  List<UF>? uF;
  List<Tecnologias>? tecnologias;

  VariaveisDeAmbienteResultado({this.uFMunicipios, this.uF, this.tecnologias});

  VariaveisDeAmbienteResultado.fromJson(Map<String, dynamic> json) {
    if (json['UFMunicipios'] != null) {
      uFMunicipios = [];
      json['UFMunicipios'].forEach((v) {
        uFMunicipios!.add(new UFMunicipios.fromJson(v));
      });
    }
    if (json['UF'] != null) {
      uF = [];
      json['UF'].forEach((v) {
        uF!.add(new UF.fromJson(v));
      });
    }
    if (json['Tecnologias'] != null) {
      tecnologias = [];
      json['Tecnologias'].forEach((v) {
        tecnologias!.add(new Tecnologias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uFMunicipios != null) {
      data['UFMunicipios'] = this.uFMunicipios!.map((v) => v.toJson()).toList();
    }
    if (this.uF != null) {
      data['UF'] = this.uF!.map((v) => v.toJson()).toList();
    }
    if (this.tecnologias != null) {
      data['Tecnologias'] = this.tecnologias!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UFMunicipios {
  String? ufId;
  String? uf;
  String? id;
  String? municipio;

  UFMunicipios({this.ufId, this.uf, this.id, this.municipio});

  UFMunicipios.fromJson(Map<String, dynamic> json) {
    ufId = json['uf_id'];
    uf = json['uf'];
    id = json['id'];
    municipio = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uf_id'] = this.ufId;
    data['uf'] = this.uf;
    data['id'] = this.id;
    data['municipio'] = this.municipio;
    return data;
  }
}

class UF {
  String? id;
  String? uf;

  UF({this.id, this.uf});

  UF.fromJson(Map<String, dynamic> json) {
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

class Tecnologias {
  String? id;
  String? tecnologia;

  Tecnologias({this.id, this.tecnologia});

  Tecnologias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tecnologia = json['tecnologia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tecnologia'] = this.tecnologia;
    return data;
  }
}