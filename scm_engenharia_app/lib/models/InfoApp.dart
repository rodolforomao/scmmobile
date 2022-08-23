class InfoApp {
  String? appName;
  String? version;
  String? buildNumber;
  String? device;
  InfoApp({
    this.appName,
    this.version,
    this.buildNumber,
    this.device,
  });

  InfoApp.fromJson(Map<String, dynamic> json) {
    appName = json['AppName'];
    version = json['Version'];
    buildNumber = json['BuildNumber'];
    device = json['Device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppName'] = this.appName;
    data['Version'] = this.version;
    data['BuildNumber'] = this.buildNumber;
    data['Device'] = this.device;
    return data;
  }
}