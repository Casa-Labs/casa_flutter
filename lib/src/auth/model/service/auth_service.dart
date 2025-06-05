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

    if (response.exception != null) {
      return LoginResponseModel(
        errorMessage: response.exception?.graphqlErrors.first.message,
      );
    } else {
      return loginResponse;
    }
  }

  Future<SocialLoginResponse?> socialLoginUser({
    required SocialLoginRequestModel socialLoginRequestModel,
  }) async {
    final SocialLoginResponse socialLoginResponse;

    final response = await _graphQLManager.singleSignOn(
      email: socialLoginRequestModel.email,
      provider: socialLoginRequestModel.provider,
      providerId: socialLoginRequestModel.providerId,
      name: socialLoginRequestModel.name,
      image: socialLoginRequestModel.image,
    );

    socialLoginResponse = SocialLoginResponse.fromJson(
      response.data!,
    );

    return socialLoginResponse;
  }

  Future<RegisterUserResponseModel?> registerUser({
    required LoginRequestModel loginRequestModel,
  }) async {
    final RegisterUserResponseModel registerUserResponse;

    final response = await _graphQLManager.registerUser(
      loginRequestModel.username,
      loginRequestModel.password,
      loginRequestModel.deviceID,
    );

    registerUserResponse = RegisterUserResponseModel.fromJson(
      response.data,
    );

    return registerUserResponse;
  }

  Future<String?> verifyRegistrationOTP({
    required String email,
    required String otp,
  }) async {
    final response = await _graphQLManager.verifyRegistrationOTP(
      email: email,
      otp: otp,
    );

    return response.data?['verifyRegistratioOTP'];
  }

  Future<String?> requestPasswordReset({
    required String email,
  }) async {
    final response = await _graphQLManager.requestPasswordReset(
      email: email,
    );

    return response.data?['requestPasswordReset'];
  }

  Future<String?> sendRegistrationOTP({
    required String email,
  }) async {
    final response = await _graphQLManager.sendRegistrationOTP(
      email: email,
    );

    return response.data?['sendRegistrationOTP'];
  }

  Future<String?> verifyOTPForPasswordUpdate({
    required String email,
    required String otp,
  }) async {
    final response = await _graphQLManager.verifyOTPForPasswordUpdate(
      email: email,
      otp: otp,
    );

    return response.data?['verifyOTPForPasswordUpdate'];
  }

  Future<String?> updatePasswordAfterVerification({
    required String email,
    required String newPassword,
  }) async {
    final response = await _graphQLManager.updatePasswordAfterVerification(
      email: email,
      newPassword: newPassword,
    );

    return response.data?['updatePasswordAfterVerification'];
  }

  Future<String?> updatePasswordWithinApp({
    required String email,
    required String newPassword,
  }) async {
    final response = await _graphQLManager.updatePasswordWithinApp(
      email: email,
      newPassword: newPassword,
    );

    return response.data?['updatePasswordWithinApp'];
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
    String? landMark,
    String? tag,
  }) async {
    final AddUserAddressResponseModel addUserAddressResponse;

    final response = await _graphQLManager.addUserAddress(
      userId: userId,
      address: address,
      city: city,
      state: state,
      pinCode: pinCode,
      country: country,
      landmark: landMark,
      tag: tag,
    );

    addUserAddressResponse = AddUserAddressResponseModel.fromJson(
      response.data,
    );

    return addUserAddressResponse;
  }
}
