import '../../../../network/graph_ql_manager.dart';
import '../../../auth/model/add_user_address_response_model.dart';

class LocationService {

  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<AddUserAddressResponseModel?> addUserAddress({
    required String userId,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String country, required String landmark,
  }) async {
    final AddUserAddressResponseModel addUserAddressResponse;

    final response = await _graphQLManager.addUserAddress(
      userId: userId,
      address: address,
      city: city,
      state: state,
      pinCode: pinCode,
      country: country,
      landmark: landmark
    );

    addUserAddressResponse = AddUserAddressResponseModel.fromJson(
      response.data,
    );

    return addUserAddressResponse;
  }
}