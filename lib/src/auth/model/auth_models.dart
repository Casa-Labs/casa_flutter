class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });
}

class LoginResponseModel {
  Login? login;

  LoginResponseModel({
    this.login,
  });

  LoginResponseModel.fromJson(Map<String, dynamic>? json) {
    login = json?['login'] != null ? Login.fromJson(json?['login']) : null;
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
  User? user;

  Login({
    this.token,
    this.user,
  });

  Login.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? authProvider;
  String? createdAt;
  String? email;
  String? id;
  String? role;
  String? updatedAt;

  User({
    this.authProvider,
    this.createdAt,
    this.email,
    this.id,
    this.role,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    authProvider = json['authProvider'];
    createdAt = json['createdAt'];
    email = json['email'];
    id = json['id'];
    role = json['role'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authProvider'] = authProvider;
    data['createdAt'] = createdAt;
    data['email'] = email;
    data['id'] = id;
    data['role'] = role;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class RegisterUserResponseModel {
  Login? register;

  RegisterUserResponseModel({
    this.register,
  });

  RegisterUserResponseModel.fromJson(Map<String, dynamic>? json) {
    register =
        json?['register'] != null ? Login.fromJson(json?['register']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (register != null) {
      data['register'] = register!.toJson();
    }
    return data;
  }
}
