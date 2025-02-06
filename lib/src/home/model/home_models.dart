class ProductModel {
  String? title;
  String? price;
  String? wasPrice;
  Map<String, dynamic>? description;
  List<Images>? images;
  String? url;
  String? id;
  int? selectedColorPosition;
  int? selectedSizePosition;
  int? quantity;
  List<dynamic>? sizes;
  bool? isSelected;

  ProductModel({
    this.title,
    this.price,
    this.wasPrice,
    this.description = const {},
    this.images,
    this.sizes = const [],
    this.id = '',
    this.selectedColorPosition = 0,
    this.selectedSizePosition = 0,
    this.quantity = 1,
    this.url,
    this.isSelected = false,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    price = json['price'] ?? "";
    wasPrice = json['was_price'] ?? "";
    sizes = List<dynamic>.from(json['sizes'] ?? []);
    description = json['description'] is List
        ? {
            for (var item in json['description'])
              item.keys.first: item.values.first
          }
        : {}; // Convert list of key-value pairs to a map;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    id = json['id'] ?? '';
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'was_price': wasPrice,
      'description': description,
      'images': images != null ? images!.map((v) => v.toJson()).toList() : [],
      'url': url,
      'sizes': sizes,
      'id': id
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['was_price'] = wasPrice;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    data['sizes'] = sizes;
    data['id'] = id;
    return data;
  }
}

class Images {
  String? src;
  String? alt;

  Images({this.src, this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['alt'] = alt;
    return data;
  }
}
