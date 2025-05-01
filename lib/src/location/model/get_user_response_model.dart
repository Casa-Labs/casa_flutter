class GetUserResponseModel {
  GetUser? getUser;

  GetUserResponseModel({
    this.getUser,
  });

  GetUserResponseModel.fromJson(Map<String, dynamic>? json) {
    getUser =
        json?['getUser'] != null ? GetUser.fromJson(json?['getUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getUser != null) {
      data['getUser'] = getUser!.toJson();
    }
    return data;
  }
}

class GetUser {
  List<Addresses>? addresses;
  String? name;
  String? email;
  String? id;

  GetUser({
    this.addresses,
    this.name,
    this.email,
    this.id,
  });

  GetUser.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    name = json['name'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['email'] = email;
    data['id'] = id;
    return data;
  }
}

class Addresses {
  String? address;
  String? city;
  String? country;
  String? createdAt;
  String? landmark;
  String? id;
  String? pinCode;
  String? state;
  String? tag;
  String? updatedAt;
  String? userId;
  bool isSelected = false;

  Addresses({
    this.address,
    this.city,
    this.country,
    this.createdAt,
    this.landmark,
    this.id,
    this.pinCode,
    this.state,
    this.tag,
    this.updatedAt,
    this.userId,
    this.isSelected = false,
  });

  Addresses.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    country = json['country'];
    createdAt = json['createdAt'];
    landmark = json['landmark'];
    id = json['id'];
    pinCode = json['pincode'];
    state = json['state'];
    tag = json['tag'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['createdAt'] = createdAt;
    data['landmark'] = landmark;
    data['id'] = id;
    data['pincode'] = pinCode;
    data['state'] = state;
    data['tag'] = tag;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    return data;
  }

  Addresses copyWith({
    String? address,
    String? city,
    String? country,
    String? createdAt,
    String? landmark,
    String? id,
    String? pinCode,
    String? state,
    String? tag,
    String? updatedAt,
    String? userId,
    bool? isSelected,
  }) {
    return Addresses(
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      landmark: landmark ?? this.landmark,
      id: id ?? this.id,
      pinCode: pinCode ?? this.pinCode,
      state: state ?? this.state,
      tag: tag ?? this.tag,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
