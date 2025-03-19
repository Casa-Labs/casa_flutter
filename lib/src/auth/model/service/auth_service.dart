import 'package:casaflutter/network/graph_ql_manager.dart';
import 'package:casaflutter/src/auth/model/add_preferences_response_model.dart';
import 'package:casaflutter/src/auth/model/add_user_address_response_model.dart';
import 'package:casaflutter/src/auth/model/auth_models.dart';
import 'package:casaflutter/src/auth/model/update_user_details_response_model.dart';

class AuthService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<LoginResponseModel?> loginUser({
    required LoginRequestModel loginRequestModel,
  }) async {
    final LoginResponseModel loginResponse;

    final response = await _graphQLManager.loginUser(
      loginRequestModel.username,
      loginRequestModel.password,
    );

    loginResponse = LoginResponseModel.fromJson(
      response.data,
    );

    return loginResponse;
  }
 Future<GoogleLoginResponse?> googleLoginUser({
    required GoogleLoginRequestModel googleLoginRequestModel,
  }) async {
    final GoogleLoginResponse googleLoginResponse;

    final response = await _graphQLManager.singleSignOn(
      googleLoginRequestModel.email,
      googleLoginRequestModel.provider,
      googleLoginRequestModel.providerId,
    );

    googleLoginResponse = GoogleLoginResponse.fromJson(
      response.data!,
    );

    return googleLoginResponse;
  }



  Future<RegisterUserResponseModel?> registerUser({
    required LoginRequestModel loginRequestModel,
  }) async {
    final RegisterUserResponseModel registerUserResponse;

    final response = await _graphQLManager.registerUser(
      loginRequestModel.username,
      loginRequestModel.password,
    );

    registerUserResponse = RegisterUserResponseModel.fromJson(
      response.data,
    );

    return registerUserResponse;
  }

  Future<bool?> deleteUser({
    required String userId,
  }) async {
    final response = await _graphQLManager.deleteUser(
      userId: userId,
    );

    final deleteUSer = response.data?['deleteUser'];

    return deleteUSer;
  }

  Future<UpdateUserDetailsResponseModel?> updateUserDetails({
    required String userId,
    required String name,
    required String email,
    required String phone,
  }) async {
    final UpdateUserDetailsResponseModel updateUserDetailsResponse;

    final response = await _graphQLManager.updateUserDetails(
      userId: userId,
      name: name,
      email: email,
      phone: phone,
    );

    updateUserDetailsResponse = UpdateUserDetailsResponseModel.fromJson(
      response.data,
    );

    return updateUserDetailsResponse;
  }

  Future<AddPreferencesResponseModel?> addStylePreferences({
    required String userId,
    required List<String> styles,
  }) async {
    final AddPreferencesResponseModel addPreferencesResponse;

    final response = await _graphQLManager.addStylePreferences(
      userId: userId,
      styles: styles,
    );

    addPreferencesResponse = AddPreferencesResponseModel.fromJson(
      response.data,
    );

    return addPreferencesResponse;
  }

  Future<AddPreferencesResponseModel?> addBodyTypePreferences({
    required String userId,
    required List<String> bodyTypes,
  }) async {
    final AddPreferencesResponseModel addPreferencesResponse;

    final response = await _graphQLManager.addBodyTypePreferences(
      userId: userId,
      bodyTypes: bodyTypes,
    );

    addPreferencesResponse = AddPreferencesResponseModel.fromJson(
      response.data,
    );

    return addPreferencesResponse;
  }

  Future<AddPreferencesResponseModel?> addFitPreferences({
    required String userId,
    required List<String> fitPreferences,
  }) async {
    final AddPreferencesResponseModel addPreferencesResponse;

    final response = await _graphQLManager.addFitPreferences(
      userId: userId,
      fitPreferences: fitPreferences,
    );

    addPreferencesResponse = AddPreferencesResponseModel.fromJson(
      response.data,
    );

    return addPreferencesResponse;
  }

  Future<AddUserAddressResponseModel?> addUserAddress({
    required String userId,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String country,
  }) async {
    final AddUserAddressResponseModel addUserAddressResponse;

    final response = await _graphQLManager.addUserAddress(
      userId: userId,
      address: address,
      city: city,
      state: state,
      pinCode: pinCode,
      country: country,
    );

    addUserAddressResponse = AddUserAddressResponseModel.fromJson(
      response.data,
    );

    return addUserAddressResponse;
  }
}
