import 'package:casaflutterapp/utils/base_model.dart';

class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });
}

class GoogleLoginRequestModel {
  String email;
  String provider;
  String providerId;
  String name;
  String image;

  GoogleLoginRequestModel({
    required this.email,
    required this.provider,
    required this.providerId,
    required this.name,
    required this.image,
  });
}

class LoginResponseModel extends BaseModel {
  Login? login;

  LoginResponseModel({
    this.login,
    super.errorMessage,
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
  String? name;
  String? phone;
  String? role;
  String? updatedAt;
  String? profileImage;
  bool? isRegistered;
  bool? isVerified;

  User({
    this.authProvider,
    this.createdAt,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.role,
    this.updatedAt,
    this.profileImage,
    this.isRegistered,
    this.isVerified,
  });

  User.fromJson(Map<String, dynamic>? json) {
    authProvider = json?['authProvider'];
    createdAt = json?['createdAt'];
    email = json?['email'];
    id = json?['id'];
    name = json?['name'];
    phone = json?['phone'];
    role = json?['role'];
    updatedAt = json?['updatedAt'];
    profileImage = json?['profileImage'];
    isRegistered = json?['isRegistered'];
    isVerified = json?['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authProvider'] = authProvider;
    data['createdAt'] = createdAt;
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['role'] = role;
    data['updatedAt'] = updatedAt;
    data['profileImage'] = profileImage;
    data['isRegistered'] = isRegistered;
    data['isVerified'] = isVerified;
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

class GoogleLoginResponse {
  SingleSignOn? singleSignOn;

  GoogleLoginResponse({
    this.singleSignOn,
  });

  GoogleLoginResponse.fromJson(Map<String, dynamic> json) {
    singleSignOn = json['SingleSignOn'] != null
        ? SingleSignOn.fromJson(json['SingleSignOn'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (singleSignOn != null) {
      data['SingleSignOn'] = singleSignOn!.toJson();
    }
    return data;
  }
}

class SingleSignOn {
  String? token;
  User? user;

  SingleSignOn({
    this.token,
    this.user,
  });

  SingleSignOn.fromJson(Map<String, dynamic> json) {
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

class GoogleUser {
  String? email;
  String? id;

  GoogleUser({
    this.email,
    this.id,
  });

  GoogleUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    return data;
  }
}

class VerifyOTPAndSendWelcomeEmailModel {
  VerifyOTPAndSendWelcomeEmail? verifyOTPAndSendWelcomeEmail;

  VerifyOTPAndSendWelcomeEmailModel({
    this.verifyOTPAndSendWelcomeEmail,
  });

  VerifyOTPAndSendWelcomeEmailModel.fromJson(Map<String, dynamic>? json) {
    verifyOTPAndSendWelcomeEmail = json?['verifyOTPAndSendWelcomeEmail'] != null
        ? VerifyOTPAndSendWelcomeEmail.fromJson(
            json?['verifyOTPAndSendWelcomeEmail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (verifyOTPAndSendWelcomeEmail != null) {
      data['verifyOTPAndSendWelcomeEmail'] =
          verifyOTPAndSendWelcomeEmail!.toJson();
    }
    return data;
  }
}

class VerifyOTPAndSendWelcomeEmail {
  User? user;

  VerifyOTPAndSendWelcomeEmail({
    this.user,
  });

  VerifyOTPAndSendWelcomeEmail.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
