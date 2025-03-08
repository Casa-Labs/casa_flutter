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

  UpdateUserDetails({
    this.id,
    this.profileImage,
    this.name,
    this.email,
    this.phone,
  });

  UpdateUserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profileImage'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profileImage'] = profileImage;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
