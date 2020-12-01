class ModelNotificacao {
  Notification notification;
  Data data;

  ModelNotificacao({this.notification, this.data});

  ModelNotificacao.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Notification {
  String title;
  String body;

  Notification({this.title, this.body});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class Data {
  String idNotificacao;
  String priority;
  String title;
  String clickAction;
  String message;
  String contentAvailable;

  Data(
      {this.idNotificacao,
        this.priority,
        this.title,
        this.clickAction,
        this.message,
        this.contentAvailable});

  Data.fromJson(Map<String, dynamic> json) {
    idNotificacao = json['idNotificacao'];
    priority = json['priority'];
    title = json['title'];
    clickAction = json['click_action'];
    message = json['message'];
    contentAvailable = json['content_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNotificacao'] = this.idNotificacao;
    data['priority'] = this.priority;
    data['title'] = this.title;
    data['click_action'] = this.clickAction;
    data['message'] = this.message;
    data['content_available'] = this.contentAvailable;
    return data;
  }
}