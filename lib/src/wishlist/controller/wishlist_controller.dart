import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
import 'package:casaflutterapp/src/wishlist/model/save_item_to_closet_model.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';
import '../../../utils/utils.dart';
import '../../home/model/home_models.dart';
import '../model/add_board_to_closet_model.dart';
import '../model/get_closet_model.dart';
import '../model/service/wishlist_service.dart';
import '../model/wishlist_models.dart';

class WishlistController extends GetxController {
  // ========= OBJECTS ============= //
  final WishlistService _wishlistService = WishlistService();
  // ========= CONTROLLERS ========= //
  TextEditingController searchController = TextEditingController();
  TextEditingController closetController = TextEditingController();

  // ========= VARIABLES ========= //
  final userID = PreferenceManager.getString(PreferenceManager.userId);
  final RxSet<String> selectedClosets = <String>{}.obs;
  RxList<ClothingItems> wishlistData = <ClothingItems>[].obs;
  RxList<GetUserClosets> getUserClosetList = <GetUserClosets>[].obs;
  RxList<SaveItem> wishItemList = <SaveItem>[].obs;
  RxBool isDeleted = false.obs;
  RxBool isWishItemDeleted = false.obs;
  RxBool isBottomSheet = false.obs;
  RxInt itemIndex = (-1).obs;

  RxString searchQuery = ''.obs;
  RxString selectedImage = ''.obs;
  bool isLoading = true;
  // ========== STATES ========== //

  @override
  void onInit() {
    super.onInit();
    getUserClosets();
    selectedImage.value = imageLinks[0];
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

// ========== UI FUNCTIONS ========== //
  List<ClothingItems> get filteredWishlist {
    if (searchQuery.value.isEmpty) {
      return wishlistData;
    }
    return wishlistData
        .where((wishlist) => wishlist.name!
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void addCloset() async {
    if (closetController.text.isNotEmpty) {
      wishlistData.add(
        ClothingItems(
          imageUrl: selectedImage.value,
          name: closetController.text,
        ),
      );
      closetInit();
    }
  }

  void removeCloset(ClothingItems wishlist) async {
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
      if (wishItemList[i].product!.isSelected!) {
        removeItemFromClothingItem(
            itemId: wishItemList[i].id!, isMultiple: true);
      }
    }
    getSavedItemsToCloset(clothingItemId: wishItemList[0].clothingItem!.id!);
    showToast(message: "All Item removed from wishlist!!");
  }

  void wishSelectedtem(int index) {
    wishItemList[index].product!.isSelected =
        !wishItemList[index].product!.isSelected!;
    wishItemList.refresh();
  }

  // ========== APIs FUNCTIONS ========== //
  Future<void> createCloset() async {
    var response = await _wishlistService.createCloset();
    if (response != null) {
      getUserClosets();
    }
  }

  Future<void> getUserClosets() async {
    GetClosetRequestModel getClosetRequestModel = GetClosetRequestModel(
      userId: userID!,
    );
    try {
      isLoading = true;
      update();
      var response = await _wishlistService.getUserClosets(
          getClosetRequestModel: getClosetRequestModel);
      // logg.d("get Data ====> $response");
      if (response != null) {
        if (response.getUserClosets!.isEmpty) {
          createCloset();
        } else {
          if (response.getUserClosets!.first.clothingItems!.isEmpty) {
            addItemToCloset(
                closetId: response.getUserClosets!.first.id.toString(),
                imageUrl: AppStrings.defaultClosetImageUrl,
                name: AppStrings.defaultClosetName);
          } else {
            getUserClosetList(response.getUserClosets);
            wishlistData(getUserClosetList.first.clothingItems);
          }
        }
      }
      isLoading = false;
      update();
    } catch (e) {
      logg.e('get error to fetch closet data $e');
      isLoading = false;
      update();
    }
  }

  Future<void> addItemToCloset(
      {required String closetId,
      required String imageUrl,
      required String name}) async {
    AddBoardRequestModel addBoardRequestModel = AddBoardRequestModel(
      closetId: closetId,
      imageUrl: imageUrl,
      name: name,
    );
    var response = await _wishlistService.addItemToCloset(
        addBoardRequestModel: addBoardRequestModel);
    logg.d("get Data ====> $response");
    showToast(
      message: "Closet creted successfully!!",
    );
    getUserClosets();
  }

  Future<void> saveItemToCloset(
      {required String clothingItemId, required String productId}) async {
    SaveItemToClosetRequestModel saveItemToClosetRequestModel =
        SaveItemToClosetRequestModel(
      clothingItemId: clothingItemId,
      productId: productId,
    );
    var response = await _wishlistService.saveItemToCloset(
        saveItemToClosetRequestModel: saveItemToClosetRequestModel);
    showToast(
      message: "Item added to wishlist!!",
    );
    logg.d("get Data save item ====> $response");
    getUserClosets();
  }

  Future<void> removeItemFromCloset({required String itemId}) async {
    RemoveClosetItemRequestModel removeClosetItemRequestModel =
        RemoveClosetItemRequestModel(
      itemId: itemId,
    );
    var response = await _wishlistService.removeItemFromCloset(
        removeClosetItemRequestModel: removeClosetItemRequestModel);
    getUserClosets();
    if (response != null &&
        response.removeItemFromCloset != null &&
        response.removeItemFromCloset!) {
      showToast(message: "Closet deleted successfully!!");
    }
    logg.d("get Delete save item ====> $response");
  }

  Future<void> getSavedItemsToCloset({required String clothingItemId}) async {
    GetSavedItemsToClosetRequestModel getSavedItemsToClosetRequestModel =
        GetSavedItemsToClosetRequestModel(
      clothingItemId: clothingItemId,
      userId: userID!,
    );
    var response = await _wishlistService.getSavedItemsToCloset(
        getSavedItemsToClosetRequestModel: getSavedItemsToClosetRequestModel);
    wishItemList(response!.getSavedItems!);
    logg.d("get Date save item ====> $response");
  }

  Future<void> removeItemFromClothingItem(
      {required String itemId, bool isMultiple = false}) async {
    RemoveClothingItemRequestModel removeClothingItemRequestModel =
        RemoveClothingItemRequestModel(
      itemId: itemId,
    );
    var response = await _wishlistService.removeItemFromClothingItem(
        removeClothingItemRequestModel: removeClothingItemRequestModel);
    if (response != null &&
        response.removeItemFromClothingItem != null &&
        response.removeItemFromClothingItem! &&
        !isMultiple) {
      getSavedItemsToCloset(clothingItemId: wishItemList[0].clothingItem!.id!);
      showToast(message: "Item removed from wishlist!!");
    }
    logg.d("get Delete save item ====> $response");
  }

  //=========== CONSTANT LIST =========== //

  List<String> imageLinks = [
    "https://images.pexels.com/photos/255379/pexels-photo-255379.jpeg?cs=srgb&dl=pexels-padrinan-255379.jpg&fm=jpg",
    'https://t3.ftcdn.net/jpg/08/52/51/04/360_F_852510478_KdKJ1xGmlHICE8TD3QM68W6m7m1E7fHT.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcL3kn1Z7tCYhQa-vOaLHwHTPIT81-uLoDBw&s',
    'https://media.istockphoto.com/id/833727890/photo/wooden-table-background.jpg?s=170667a&w=0&k=20&c=X0T-EH3_hWKTTVOrEYxPWpFWHUzKD3VkMMAyOrmh8ac=',
    'https://rukminim2.flixcart.com/image/850/1000/jjbqufk0/poster/r/h/h/large-vlnature00091a-natural-scene-of-mountain-near-lake-vinyl-original-imaeh9vdnj9xxfau.jpeg?q=90&crop=false',
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

  final List<ProductModelFilter> brandFilter = [
    ProductModelFilter(leading: '', title: 'Zara'),
    ProductModelFilter(leading: '', title: 'H&M'),
    ProductModelFilter(leading: '', title: 'Gap'),
    ProductModelFilter(leading: '', title: 'CASA'),
    ProductModelFilter(leading: '', title: 'Tommy hilfiger')
  ];

  final List<ProductModelFilter> productFilter = [
    ProductModelFilter(leading: '', title: 'Topwear'),
    ProductModelFilter(leading: '', title: 'Shirt'),
    ProductModelFilter(leading: '', title: 'Sweatshirt'),
    ProductModelFilter(leading: '', title: 'T- shirt'),
    ProductModelFilter(leading: '', title: 'Hoodie')
  ];

  final List<ProductModelFilter> colorFilter = [
    ProductModelFilter(leading: '', title: 'Black'),
    ProductModelFilter(leading: '', title: 'Brown'),
    ProductModelFilter(leading: '', title: 'Green'),
    ProductModelFilter(leading: '', title: 'Denim'),
    ProductModelFilter(leading: '', title: 'Zebra print')
  ];

  final List<ProductModelFilter> sizedFilter = [
    ProductModelFilter(leading: '', title: 'XXS'),
    ProductModelFilter(leading: '', title: 'XS'),
    ProductModelFilter(leading: '', title: 'S'),
    ProductModelFilter(leading: '', title: 'M'),
    ProductModelFilter(leading: '', title: 'L'),
    ProductModelFilter(leading: '', title: 'XL'),
    ProductModelFilter(leading: '', title: 'XXL')
  ];
}
