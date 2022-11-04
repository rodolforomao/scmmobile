class InfoApp {
  String? appName = '';
  String? idAplicativo = '2';
  String? version= '';
  String? buildNumber = '';
  String? device = '';
  String? deviceVersion = '';
  String? idDevice= '';
  String? idProduct = '';
  String? dataAcesso= '';
  String? latitude= '';
  String? longitude= '';
  InfoApp({
    this.appName,
    this.idAplicativo,
    this.version,
    this.buildNumber,
    this.device,
    this.deviceVersion,
    this.idDevice,
    this.idProduct,
    this.dataAcesso,
    this.latitude,
    this.longitude,
  });

  InfoApp.fromJson(Map<String, dynamic> json) {
    appName = json['AppName'];
    idAplicativo = json['IdAplicativo'];
    version = json['Version'];
    buildNumber = json['BuildNumber'];
    device = json['Device'];
    deviceVersion = json['DeviceVersion'];
    idDevice = json['IdDevice'];
    idProduct = json['IdProduct'];
    dataAcesso = json['DataAcesso'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppName'] = appName;
    data['IdAplicativo'] = idAplicativo;
    data['Version'] = version;
    data['BuildNumber'] = buildNumber;
    data['Device'] = device;
    data['DeviceVersion'] = deviceVersion;
    data['IdDevice'] = idDevice;
    data['IdProduct'] = idProduct;
    data['DataAcesso'] = dataAcesso;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    return data;
  }
}

