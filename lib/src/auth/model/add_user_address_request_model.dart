class AddUserAddressRequestModel {
  String? userId;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? country;

  AddUserAddressRequestModel({
    this.userId,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.country,
  });

  AddUserAddressRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['country'] = country;
    return data;
  }
}
