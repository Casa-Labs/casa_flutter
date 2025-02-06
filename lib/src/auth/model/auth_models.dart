class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({required this.username, required this.password});
}

class LoginResponseModel {
  Data? data;

  LoginResponseModel({this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Login? login;

  Data({this.login});

  Data.fromJson(Map<String, dynamic> json) {
    login = json['login'] != null ? Login.fromJson(json['login']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (login != null) {
      data['login'] = login!.toJson();
    }
    return data;
  }
}

class Login {
  String? token;

  Login({this.token});

  Login.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
