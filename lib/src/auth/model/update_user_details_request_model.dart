class UpdateUserDetailsRequestModel {
  String? userId;
  String? name;
  String? email;
  String? phone;

  UpdateUserDetailsRequestModel({
    this.userId,
    this.name,
    this.email,
    this.phone,
  });

  UpdateUserDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
