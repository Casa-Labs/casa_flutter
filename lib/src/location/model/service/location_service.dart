import 'package:casaflutter/src/location/model/get_user_response_model.dart';

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
    required String country,
    required String landmark,
    required String tag,
  }) async {
    final AddUserAddressResponseModel addUserAddressResponse;

    final response = await _graphQLManager.addUserAddress(
      userId: userId,
      address: address,
      city: city,
      state: state,
      pinCode: pinCode,
      country: country,
      landmark: landmark,
      tag: tag,
    );

    addUserAddressResponse = AddUserAddressResponseModel.fromJson(
      response.data,
    );

    return addUserAddressResponse;
  }

  Future<Addresses?> updateUserAddress({
    required String id,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String country,
    required String landmark,
    required String tag,
  }) async {
    final Addresses addressesResponse;

    final response = await _graphQLManager.updateUserAddress(
      id: id,
      address: address,
      city: city,
      state: state,
      pinCode: pinCode,
      country: country,
      landmark: landmark,
      tag: tag,
    );

    addressesResponse = Addresses.fromJson(
      response.data?['updateUserAddress'],
    );

    return addressesResponse;
  }

  Future<GetUserResponseModel?> getUser({
    required String userId,
  }) async {
    final GetUserResponseModel getUserResponseModel;

    final response = await _graphQLManager.getUser(
      userId: userId,
    );

    getUserResponseModel = GetUserResponseModel.fromJson(
      response.data,
    );

    return getUserResponseModel;
  }

  Future<bool?> deleteUserAddress({
    required String addressId,
  }) async {
    final response = await _graphQLManager.deleteUserAddress(
      addressId: addressId,
    );

    return response.data?['deleteUserAddress'];
  }
}
