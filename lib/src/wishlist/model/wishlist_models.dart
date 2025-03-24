// ====Create Closet ==== //
class CreateClosetResponse {
  CreateCloset? createCloset;

  CreateClosetResponse({this.createCloset});

  CreateClosetResponse.fromJson(Map<String, dynamic> json) {
    createCloset = json['createCloset'] != null
        ? CreateCloset.fromJson(json['createCloset'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (createCloset != null) {
      data['createCloset'] = createCloset!.toJson();
    }
    return data;
  }
}

class CreateCloset {
  String? createdAt;
  String? id;
  String? name;
  User? user;

  CreateCloset({this.createdAt, this.id, this.name, this.user});

  CreateCloset.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    name = json['name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['name'] = name;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

// ==== Remove Board From Closet ==== //
class RemoveClosetItemRequestModel {
  String itemId;

  RemoveClosetItemRequestModel({
    required this.itemId,
  });
}

class RemoveClosetItemResponseModel {
  bool? removeItemFromCloset;

  RemoveClosetItemResponseModel({this.removeItemFromCloset});

  RemoveClosetItemResponseModel.fromJson(Map<String, dynamic> json) {
    removeItemFromCloset = json['removeItemFromCloset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['removeItemFromCloset'] = removeItemFromCloset;
    return data;
  }
}
