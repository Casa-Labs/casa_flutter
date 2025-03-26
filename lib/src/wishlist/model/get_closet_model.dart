class GetClosetRequestModel {
  String userId;

  GetClosetRequestModel({
    required this.userId,
  });
}

class GetClosetByIdRequestModel {
  String getClosetId;

  GetClosetByIdRequestModel({
    required this.getClosetId,
  });
}


class GetUserClosetsResponseModel {
  List<GetUserClosets>? getUserClosets;

  GetUserClosetsResponseModel({this.getUserClosets});

  GetUserClosetsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['getUserClosets'] != null) {
      getUserClosets = <GetUserClosets>[];
      json['getUserClosets'].forEach((v) {
        getUserClosets!.add(GetUserClosets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getUserClosets != null) {
      data['getUserClosets'] =
          getUserClosets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserClosets {
  List<ClothingItems>? clothingItems;
  String? name;
  String? id;
  String? createdAt;

  GetUserClosets({this.clothingItems, this.name, this.id, this.createdAt});

  GetUserClosets.fromJson(Map<String, dynamic> json) {
    if (json['clothingItems'] != null) {
      clothingItems = <ClothingItems>[];
      json['clothingItems'].forEach((v) {
        clothingItems!.add(ClothingItems.fromJson(v));
      });
    }
    name = json['name'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clothingItems != null) {
      data['clothingItems'] =
          clothingItems!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['id'] = id;
    data['createdAt'] = createdAt;
    return data;
  }
}

class GetClosetByIdResponseModel {
  GetCloset? getCloset;

  GetClosetByIdResponseModel({this.getCloset});

  GetClosetByIdResponseModel.fromJson(Map<String, dynamic> json) {
    getCloset = json['getCloset'] != null
        ? GetCloset.fromJson(json['getCloset'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getCloset != null) {
      data['getCloset'] = getCloset!.toJson();
    }
    return data;
  }
}

class GetCloset {
  User? user;
  String? name;
  String? id;
  String? createdAt;
  List<ClothingItems>? clothingItems;

  GetCloset(
      {this.user, this.name, this.id, this.createdAt, this.clothingItems});

  GetCloset.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    name = json['name'];
    id = json['id'];
    createdAt = json['createdAt'];
    if (json['clothingItems'] != null) {
      clothingItems = <ClothingItems>[];
      json['clothingItems'].forEach((v) {
        clothingItems!.add(ClothingItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['name'] = name;
    data['id'] = id;
    data['createdAt'] = createdAt;
    if (clothingItems != null) {
      data['clothingItems'] =
          clothingItems!.map((v) => v.toJson()).toList();
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

class ClothingItems {
  String? name;
  String? imageUrl;
  String? id;
  String? createdAt;

  ClothingItems({this.name, this.imageUrl, this.id, this.createdAt});

  ClothingItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    data['createdAt'] = createdAt;
    return data;
  }
}