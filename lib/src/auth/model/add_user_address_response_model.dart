class AddUserAddressResponseModel {
  AddUserAddress? addUserAddress;

  AddUserAddressResponseModel({
    this.addUserAddress,
  });

  AddUserAddressResponseModel.fromJson(Map<String, dynamic>? json) {
    addUserAddress = json?['addUserAddress'] != null
        ? AddUserAddress.fromJson(json?['addUserAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addUserAddress != null) {
      data['addUserAddress'] = addUserAddress!.toJson();
    }
    return data;
  }
}

class AddUserAddress {
  String? id;
  String? userId;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? pincode;
  String? country;

  AddUserAddress({
    this.id,
    this.userId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.country,
  });

  AddUserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    address = json['address'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['address'] = address;
    data['landmark'] = landmark;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['country'] = country;
    return data;
  }
}
