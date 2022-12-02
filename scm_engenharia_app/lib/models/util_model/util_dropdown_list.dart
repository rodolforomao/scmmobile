class UtilDropdownList {
  int? id;
  String? txt;
  String? txtDescricao;

  UtilDropdownList({this.id, this.txt, this.txtDescricao});

  UtilDropdownList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    json['Txt'] == null ? txt = '' : txt = json['Txt'].toString().toUpperCase();
    json['TxtDescricao'] == null ? txtDescricao = '' : txtDescricao = json['TxtDescricao'].toString().toUpperCase();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.id;
    data['Txt'] = this.txt;
    data['TxtDescricao'] = this.txtDescricao;
    return data;
  }
}