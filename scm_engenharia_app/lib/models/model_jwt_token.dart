class ModelJWTToken {
  String User;
  String password;

  ModelJWTToken({
    this.User,
    this.password,
  });

  ModelJWTToken.fromJson(Map<String, dynamic> json) {
    User = json['user'];
    password = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.User;
    data['pass'] = this.password;
    return data;
  }
}
