class AddBoardRequestModel {
  String closetId;
  String name;
  String imageUrl;

  AddBoardRequestModel({
    required this.closetId,
    required this.name,
    required this.imageUrl,
  });
}

class AddBoardResponse {
  AddItemToCloset? addItemToCloset;

  AddBoardResponse({this.addItemToCloset});

  AddBoardResponse.fromJson(Map<String, dynamic> json) {
    addItemToCloset = json['addItemToCloset'] != null
        ? AddItemToCloset.fromJson(json['addItemToCloset'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addItemToCloset != null) {
      data['addItemToCloset'] = addItemToCloset!.toJson();
    }
    return data;
  }
}

class AddItemToCloset {
  String? id;
  String? createdAt;
  Closet? closet;
  String? imageUrl;
  String? name;

  AddItemToCloset(
      {this.id, this.createdAt, this.closet, this.imageUrl, this.name});

  AddItemToCloset.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    createdAt = json['createdAt'] ?? "";
    closet = json['closet'] != null ? Closet.fromJson(json['closet']) : null;
    imageUrl = json['imageUrl'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? "";
    data['createdAt'] = createdAt ?? "";
    if (closet != null) {
      data['closet'] = closet!.toJson();
    }
    data['imageUrl'] = imageUrl ?? "";
    data['name'] = name ?? "";
    return data;
  }
}

class Closet {
  String? id;
  String? name;

  Closet({this.id, this.name});

  Closet.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? "";
    data['name'] = name ?? "";
    return data;
  }
}
