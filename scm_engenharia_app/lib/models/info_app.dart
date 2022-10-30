class InfoApp {
  String? appName = '';
  String? version= '';
  String? buildNumber = '';
  String? device = '';
  String? idDevice= '';
  String? idProduct = '';
  String? dataAcesso= '';
  String? os = '';
  String? latitude= '';
  String? longitude= '';
  InfoApp({
    this.appName,
    this.version,
    this.buildNumber,
    this.device,
    this.idDevice,
    this.idProduct,
    this.dataAcesso,
    this.os,
    this.latitude,
    this.longitude,
  });

  InfoApp.fromJson(Map<String, dynamic> json) {
    appName = json['AppName'];
    version = json['Version'];
    buildNumber = json['BuildNumber'];
    device = json['Device'];
    idDevice = json['IdDevice'];
    idProduct = json['IdProduct'];
    dataAcesso = json['DataAcesso'];
    os = json['Os'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppName'] = appName;
    data['Version'] = version;
    data['BuildNumber'] = buildNumber;
    data['Device'] = device;
    data['IdDevice'] = idDevice;
    data['IdProduct'] = idProduct;
    data['DataAcesso'] = dataAcesso;
    data['Os'] = os;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    return data;
  }
}

