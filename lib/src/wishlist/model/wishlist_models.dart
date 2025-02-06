import '../../home/model/home_models.dart';

class WishlistModels {
  String name;
  String imageUrl;
  List<ProductModel> productList;

  WishlistModels({
    this.name = "",
    this.imageUrl = "",
    this.productList = const [],
  });

  factory WishlistModels.fromJson(Map<dynamic, dynamic> parsedJson) {
    return WishlistModels(
      name: parsedJson['name'] ?? '',
      imageUrl: parsedJson['image_url'] ?? '',
      productList:
          (parsedJson['product_list'] as List<dynamic>? ?? []).map((item) {
        if (item is Map<String, dynamic>) {
          return ProductModel.fromJson(item);
        }
        return ProductModel(); // Return a default item if the cast fails
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': imageUrl,
      'product_list': productList,
    };
  }
}
