import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/model/home_models.dart';
import '../model/wishlist_models.dart';

class WishlistController extends GetxController {
  RxList<WishlistModels> wishlistData = <WishlistModels>[].obs;
  RxList<ProductModel> wishItemList = <ProductModel>[].obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController closetController = TextEditingController();
  RxBool isDeleted = false.obs;
  RxBool isWishItemDeleted = false.obs;
  RxBool isBottomSheet = false.obs;
  RxInt itemIndex = (-1).obs;

  RxString searchQuery = ''.obs;
  RxString selectedImage = ''.obs;
  ProductModel productModel = ProductModel(
      price: "₹20",
      title: "White and golden shorts for women",
      images: [
        Images(
            src:
                'https://srstore.in/cdn/shop/files/O1CN01iWwp191LUMaFHeZpu__2209587281302-0-cib_2000x.jpg?v=1712055840'),
      ]);

  @override
  void onInit() {
    super.onInit();
    wishlistData.add(WishlistModels(
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/031/623/946/small_2x/background-for-productgraphy-ai-generated-photo.jpg',
        name: "All Saved",
        productList: [productModel, productModel, productModel]));
    selectedImage.value = imageLinks[0];
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  List<WishlistModels> get filteredWishlist {
    if (searchQuery.value.isEmpty) {
      return wishlistData;
    }
    return wishlistData
        .where((wishlist) => wishlist.name
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void addCloset() async {
    if (closetController.text.isNotEmpty) {
      wishlistData.add(
        WishlistModels(
          imageUrl: selectedImage.value,
          name: closetController.text,
        ),
      );
      closetInit();
    }
  }

  void removeCloset(WishlistModels wishlist) async {
    wishlistData.remove(wishlist);
  }

  void closetInit() {
    closetController.text = '';
    selectedImage.value = imageLinks[0];
  }

  void deleteOrNot() {
    isDeleted.value = !isDeleted.value;
    wishlistData.refresh();
  }

  void wishItemDeletedOrNot() {
    isWishItemDeleted.value = !isWishItemDeleted.value;
  }

  void wishRemoveItem() {
    for (var i = 0; i < wishItemList.length; i++) {
      if (wishItemList[i].isSelected!) {
        wishItemList.removeAt(i);
      }
    }
  }

  void wishSelectedtem(int index) {
    wishItemList[index].isSelected = !wishItemList[index].isSelected!;
    wishItemList.refresh();
  }

  List<String> imageLinks = [
    "https://images.pexels.com/photos/255379/pexels-photo-255379.jpeg?cs=srgb&dl=pexels-padrinan-255379.jpg&fm=jpg",
    'https://t3.ftcdn.net/jpg/08/52/51/04/360_F_852510478_KdKJ1xGmlHICE8TD3QM68W6m7m1E7fHT.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcL3kn1Z7tCYhQa-vOaLHwHTPIT81-uLoDBw&s',
    'https://media.istockphoto.com/id/833727890/photo/wooden-table-background.jpg?s=170667a&w=0&k=20&c=X0T-EH3_hWKTTVOrEYxPWpFWHUzKD3VkMMAyOrmh8ac=',
    'https://static.vecteezy.com/system/resources/thumbnails/037/814/719/small_2x/ai-generated-autumn-leaves-in-the-forest-nature-background-photo.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/036/226/872/small_2x/ai-generated-nature-landscapes-background-free-photo.jpg',
    'https://images.unsplash.com/photo-1593642532973-d31b6557fa68',
    'https://t3.ftcdn.net/jpg/05/54/02/68/360_F_554026892_UsZG4Tm3GPUV6fxzlpvV0qOOe9KKYvCj.jpg',
    'https://thumbs.dreamstime.com/b/incredibly-beautiful-sunset-sun-lake-sunrise-landscape-panorama-nature-sky-amazing-colorful-clouds-fantasy-design-115177001.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrM3XUaIRVRER_eqo062BNrTgS7SjjS0VJPg&s',
    'https://i0.wp.com/picjumbo.com/wp-content/uploads/red-and-blue-pillars-wallpaper-abstract-background-free-image.jpeg?w=600&quality=80',
    'https://t4.ftcdn.net/jpg/05/49/86/39/360_F_549863991_6yPKI08MG7JiZX83tMHlhDtd6XLFAMce.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs-Zs1jAhbmypFTiTem5s6YzJpLB4tyD2F_Q&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrCKVj1-g3zHrU5AeECjoDetg4Hmocpqa2BQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiRx5GqAy1DRddqSBbX_cBulb5PQB2ACvLrQ&s',
    'https://static.vecteezy.com/system/resources/previews/011/004/883/non_2x/triangular-abstract-with-security-symbol-circuit-board-modern-future-website-background-or-cover-page-for-technology-and-finance-concept-and-education-future-company-vector.jpg',
    'https://t3.ftcdn.net/jpg/04/71/33/32/360_F_471333224_bQbXMG1TuzIed78bfWp2UVLN1kyhoQYf.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcK6UYtv6T3_kmxUlPXuftZjgL2f0kgPjGYw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSyn-X3QpIM1kFPux-_PrZW5SBNhfw-BWy7Q&s',
    'https://pub-static.fotor.com/assets/bg/502d2e2f-f6cd-4508-9707-03c7663ecc1e.jpg',
    'https://img.pikbest.com/best/video_preview_img/2404/10514271-66207a321ba5d.jpg!w340',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3IoMJuoE1LC9-Ado1qPjVitRXmLkAFhV-gA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxgVcve4HzfyMm88qW1pZMuxry1tg81PE2-A&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-uWsMJev5y2_S1EpvpFSDed5oJwcPpBwbrA&s',
  ];
}
