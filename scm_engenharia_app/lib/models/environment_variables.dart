class EnvironmentVariables {
  bool? status;
  String? message;
  EnvironmentVariables? result;

  EnvironmentVariables({this.status, this.message, this.result});

  EnvironmentVariables.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['mensagem'];
    result = json['resultado'] != null
        ? EnvironmentVariables.fromJson(json['resultado'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['mensagem'] = this.message;
    if (this.result != null) {
      data['resultado'] = this.result!.toJson();
    }
    return data;
  }
}

class ResultEnvironmentVariables {
  List<UFCounties>? ufCounties;
  List<UF>? uF;
  List<Technologies>? tecnologias;

  ResultEnvironmentVariables({this.ufCounties, this.uF, this.tecnologias});

  ResultEnvironmentVariables.fromJson(Map<String, dynamic> json) {
    if (json['UFMunicipios'] != null) {
      ufCounties =  [];
      json['UFMunicipios'].forEach((v) {
       // ufCounties!.add(new UFMunicipios!.fromJson(v));
      });
    }
    if (json['UF'] != null) {
      //uF = new List<UF>();
      json['UF'].forEach((v) {
       // uF.add(new UF.fromJson(v));
      });
    }
    if (json['Tecnologias'] != null) {
      //tecnologias = new List<Tecnologias>();
      json['Tecnologias'].forEach((v) {
       // tecnologias!.add(new Tecnologias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ufCounties != null) {
      data['UFMunicipios'] = this.ufCounties!.map((v) => v.toJson()).toList();
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

class UFCounties {
  String? ufId;
  String? uf;
  String? id;
  String? counties;

  UFCounties({this.ufId, this.uf, this.id, this.counties});

  UFCounties.fromJson(Map<String, dynamic> json) {
    ufId = json['uf_id'];
    uf = json['uf'];
    id = json['id'];
    counties = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uf_id'] = this.ufId;
    data['uf'] = this.uf;
    data['id'] = this.id;
    data['municipio'] = this.counties;
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

class Technologies {
  String? id;
  String? technology;

  Technologies({this.id, this.technology});

  Technologies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    technology = json['tecnologia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tecnologia'] = this.technology;
    return data;
  }
}