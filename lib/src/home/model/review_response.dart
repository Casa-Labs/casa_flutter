class GetProductReviewModel {
  List<GetProductInteractions>? getProductInteractions;

  GetProductReviewModel({this.getProductInteractions});

  GetProductReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['getProductInteractions'] != null) {
      getProductInteractions = <GetProductInteractions>[];
      json['getProductInteractions'].forEach((v) {
        getProductInteractions!.add(GetProductInteractions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getProductInteractions != null) {
      data['getProductInteractions'] =
          getProductInteractions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetProductInteractions {
  String? id;
  String? userId;
  User? user;
  String? productId;
  bool? liked;
  bool? disliked;
  bool? viewed;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;

  GetProductInteractions(
      {this.id,
        this.userId,
        this.user,
        this.productId,
        this.liked,
        this.disliked,
        this.viewed,
        this.rating,
        this.comment,
        this.createdAt,
        this.updatedAt});

  GetProductInteractions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    productId = json['productId'];
    liked = json['liked'];
    disliked = json['disliked'];
    viewed = json['viewed'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['productId'] = productId;
    data['liked'] = liked;
    data['disliked'] = disliked;
    data['viewed'] = viewed;
    data['rating'] = rating;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class User {
  String? name;
  String? profileImage;

  User({this.name, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profileImage'] = profileImage;
    return data;
  }
}
