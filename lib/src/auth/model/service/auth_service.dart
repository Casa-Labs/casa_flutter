import 'package:casa_flutter/network/graph_ql_manager.dart';
import 'package:casa_flutter/src/auth/model/auth_models.dart';

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
}
