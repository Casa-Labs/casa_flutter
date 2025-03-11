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

  AddUserAddress({
    this.id,
    this.userId,
    this.address,
  });

  AddUserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['address'] = address;
    return data;
  }
}
