import 'package:casaflutter/network/graph_ql_manager.dart';

import '../add_board_to_closet_model.dart';
import '../create_closet_model.dart';
import '../get_closet_model.dart';
import '../remove_item_from_closet_model.dart';
import '../save_item_to_closet_model.dart';

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

  Future<AddBoardResponse?> removeItemFromCloset(
      {required RemoveItemRequestModel removeItemRequestModel}) async {
    final AddBoardResponse addBoardResponse;

    final response = await _graphQLManager.removeItemFromCloset(
        itemId: removeItemRequestModel.itemId);

    addBoardResponse = AddBoardResponse.fromJson(
      response.data!,
    );
    return addBoardResponse;
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
}
