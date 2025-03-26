import 'package:casaflutterapp/network/graph_ql_manager.dart';

import '../add_board_to_closet_model.dart';
import '../get_closet_model.dart';
import '../save_item_to_closet_model.dart';
import '../wishlist_models.dart';

class WishlistService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<CreateClosetResponse?> createCloset() async {
    final CreateClosetResponse createClosetResponse;

    final response = await _graphQLManager.createCloset(name: "Demo");

    createClosetResponse = CreateClosetResponse.fromJson(
      response.data!,
    );

    return createClosetResponse;
  }

  Future<AddBoardResponse?> addItemToCloset(
      {required AddBoardRequestModel addBoardRequestModel}) async {
    final AddBoardResponse addBoardResponse;

    final response = await _graphQLManager.addItemToCloset(
        closetId: addBoardRequestModel.closetId,
        name: addBoardRequestModel.name,
        imageUrl: addBoardRequestModel.imageUrl);

    addBoardResponse = AddBoardResponse.fromJson(
      response.data!,
    );
    return addBoardResponse;
  }

  Future<SaveItemToClosetResponseModel?> saveItemToCloset(
      {required SaveItemToClosetRequestModel
          saveItemToClosetRequestModel}) async {
    final SaveItemToClosetResponseModel saveItemToClosetRM;

    final response = await _graphQLManager.saveItemToCloset(
        clothingItemId: saveItemToClosetRequestModel.clothingItemId,
        productId: saveItemToClosetRequestModel.productId);

    saveItemToClosetRM = SaveItemToClosetResponseModel.fromJson(
      response.data!,
    );
    return saveItemToClosetRM;
  }

  Future<RemoveClosetItemResponseModel?> removeItemFromCloset(
      {required RemoveClosetItemRequestModel
          removeClosetItemRequestModel}) async {
    final RemoveClosetItemResponseModel removeClosetItemResponseModel;

    final response = await _graphQLManager.removeItemFromCloset(
        itemId: removeClosetItemRequestModel.itemId);

    removeClosetItemResponseModel = RemoveClosetItemResponseModel.fromJson(
      response.data!,
    );
    return removeClosetItemResponseModel;
  }

  Future<RemoveClothingItemResponseModel?> removeItemFromClothingItem(
      {required RemoveClothingItemRequestModel
          removeClothingItemRequestModel}) async {
    final RemoveClothingItemResponseModel removeClothingItemResponseModel;

    final response = await _graphQLManager.removeItemFromClothingItem(
        itemId: removeClothingItemRequestModel.itemId);

    removeClothingItemResponseModel = RemoveClothingItemResponseModel.fromJson(
      response.data!,
    );
    return removeClothingItemResponseModel;
  }

  Future<GetUserClosetsResponseModel?> getUserClosets(
      {required GetClosetRequestModel getClosetRequestModel}) async {
    final GetUserClosetsResponseModel getUserClosets;

    final response = await _graphQLManager.getUserClosets(
        userId: getClosetRequestModel.userId);

    getUserClosets = GetUserClosetsResponseModel.fromJson(
      response.data!,
    );
    return getUserClosets;
  }

  Future<GetUserClosetsResponseModel?> getClosetById(
      {required GetClosetByIdRequestModel getClosetByIdRequestModel}) async {
    final GetUserClosetsResponseModel getUserClosets;

    final response = await _graphQLManager.getClosetById(
        getClosetId: getClosetByIdRequestModel.getClosetId);

    getUserClosets = GetUserClosetsResponseModel.fromJson(
      response.data!,
    );
    return getUserClosets;
  }

  Future<GetSavedItemsToClosetResponseModel?> getSavedItemsToCloset(
      {required GetSavedItemsToClosetRequestModel
          getSavedItemsToClosetRequestModel}) async {
    final GetSavedItemsToClosetResponseModel getSavedItemsToClosetResponseModel;

    final response = await _graphQLManager.getSavedItemsToCloset(
        clothingItemId: getSavedItemsToClosetRequestModel.clothingItemId,
        userId: getSavedItemsToClosetRequestModel.userId);

    getSavedItemsToClosetResponseModel =
        GetSavedItemsToClosetResponseModel.fromJson(
      response.data!,
    );
    return getSavedItemsToClosetResponseModel;
  }
}
