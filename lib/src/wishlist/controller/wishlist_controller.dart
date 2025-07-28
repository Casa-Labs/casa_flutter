import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/src/wishlist/model/save_item_to_closet_model.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/preference_manager.dart';
import '../../../utils/utils.dart';
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

    selectedImage.value = imageLinks[0];
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  @override
  void onReady() {
    if ((PreferenceManager.getString(PreferenceManager.token) ?? "")
        .isNotEmpty) {
      getUserClosets();
    }
    super.onReady();
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
      userId: userID ?? "",
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
      message: "Closet created successfully",
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
      message: "Item added to wishlist",
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
      showToast(message: "Closet deleted successfully");
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
      showToast(message: "Item removed from wishlist");
    }
    logg.d("get Delete save item ====> $response");
  }

  //=========== CONSTANT LIST =========== //

  List<String> imageLinks = [
    'https://i.pinimg.com/1200x/e0/a6/ae/e0a6aea578961289899fa73e6a54c0e2.jpg',
    'https://i.pinimg.com/1200x/14/c4/43/14c4432dee640576a434b5052019e4ab.jpg',
    'https://i.pinimg.com/736x/82/37/29/82372916e934f2c36210ded34b33604b.jpg',
    'https://i.pinimg.com/736x/75/06/e1/7506e116d849d407583680e7acc1e919.jpg',
    'https://i.pinimg.com/1200x/0a/14/f4/0a14f49d6fc4d46a5c3e0fed519d3aa5.jpg',
    'https://i.pinimg.com/736x/83/88/1b/83881bee801f159be715b72f57a9d011.jpg',
    'https://i.pinimg.com/1200x/34/69/3f/34693ff99e3bf74e5b39430100b2efcf.jpg',
    'https://i.pinimg.com/1200x/55/cf/5c/55cf5c5da45485b81ee4d338860ea688.jpg',
    'https://i.pinimg.com/736x/23/ee/c1/23eec1d112017ffdb24bed7e5766bc40.jpg',
    'https://i.pinimg.com/736x/7e/bf/85/7ebf85d5c56390ce5ed1a8656ed6f9cb.jpg',
    'https://i.pinimg.com/736x/97/f9/78/97f978ae09fbeaa698eb115a428912ae.jpg',
    'https://i.pinimg.com/736x/e8/5e/2f/e85e2f84087009add505edc10680cc80.jpg',
    'https://i.pinimg.com/736x/a3/d4/e1/a3d4e1775455c8bb359caac220380d1f.jpg',
    'https://i.pinimg.com/736x/ba/a2/0a/baa20a21e01cf29e742baf9c3b72e027.jpg',
    'https://i.pinimg.com/736x/8f/d9/2a/8fd92af192f1c55ad110f0e231c5256b.jpg',
    'https://i.pinimg.com/736x/66/b0/19/66b0190f9e04043bd2ea874ee590ea96.jpg',
    'https://i.pinimg.com/1200x/17/b7/83/17b7833a8c29fdb9c59f31f27dcc7a0d.jpg',
    'https://i.pinimg.com/1200x/ac/e9/db/ace9db96f2a1574b1cb2c5c1d90758b8.jpg',
  ];
}
