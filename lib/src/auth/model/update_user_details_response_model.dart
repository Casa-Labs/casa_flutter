class UpdateUserDetailsResponseModel {
  UpdateUserDetails? updateUserDetails;

  UpdateUserDetailsResponseModel({
    this.updateUserDetails,
  });

  UpdateUserDetailsResponseModel.fromJson(Map<String, dynamic>? json) {
    updateUserDetails = json?['updateUserDetails'] != null
        ? UpdateUserDetails.fromJson(json?['updateUserDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (updateUserDetails != null) {
      data['updateUserDetails'] = updateUserDetails!.toJson();
    }
    return data;
  }
}

class UpdateUserDetails {
  String? id;
  String? profileImage;
  String? name;
  String? email;
  String? phone;
  String? role;
  bool? isDeleted;
  bool? isRegistered;
  bool? isVerified;

  UpdateUserDetails({
    this.id,
    this.profileImage,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.isDeleted,
    this.isRegistered,
    this.isVerified,
  });

  UpdateUserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profileImage'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isDeleted = json['isDeleted'];
    isRegistered = json['isRegistered'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profileImage'] = profileImage;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['isDeleted'] = isDeleted;
    data['isRegistered'] = isRegistered;
    data['isVerified'] = isVerified;
    return data;
  }
}
