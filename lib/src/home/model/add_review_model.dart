class AddReviewRequestModel {
  String productId;
  String userId;
  bool liked;
  bool disliked;
  bool viewed;
  int rating;
  String comment;

  AddReviewRequestModel({
    required this.productId,
    required this.userId,
    required this.liked,
    required this.disliked,
    required this.viewed,
    required this.rating,
    required this.comment,
  });
}

class AddReviewModel {
  RegisterProductReview? registerProductReview;

  AddReviewModel({this.registerProductReview});

  AddReviewModel.fromJson(Map<String, dynamic> json) {
    registerProductReview = json['registerProductReview'] != null
        ? RegisterProductReview.fromJson(json['registerProductReview'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (registerProductReview != null) {
      data['registerProductReview'] = registerProductReview!.toJson();
    }
    return data;
  }
}

class RegisterProductReview {
  String? id;
  String? userId;
  String? productId;
  bool? liked;
  bool? disliked;
  bool? viewed;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;

  RegisterProductReview(
      {this.id,
      this.userId,
      this.productId,
      this.liked,
      this.disliked,
      this.viewed,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt});

  RegisterProductReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
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
