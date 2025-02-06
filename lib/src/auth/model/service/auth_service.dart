import 'package:get/get.dart';

import '../../../../network/graphql_client.dart';
import '../../../../utils/preference_manager.dart';
import '../../../../utils/utils.dart';
import '../../../common/widgets/response_dialog.dart';
import '../../controller/auth_controller.dart';
import '../auth_models.dart';

class AuthService {
  final authCtrl = Get.find<AuthController>();

  Future<void> loginUser(LoginRequestModel loginVariables) async {
    const String loginMutation = '''
      mutation Login(\$username: String!, \$password: String!) {
        login(username: \$username, password: \$password) {
          refCode
          token
        }
      }
    ''';

    final variables = {
      "username": loginVariables.username,
      "password": loginVariables.password,
    };

    final response = await GraphQLClientService()
        .performMutation(document: loginMutation, variables: variables);

    if (response.hasException) {
      logg.e(response.exception.toString());
      Get.dialog(
        ResponseDialog(
          text:
              'Login Failed: ${response.exception?.graphqlErrors.first.message ?? "Unknown error"}',
          onPressed: () => Get.back(),
          isErrorDialog: true,
        ),
        barrierDismissible: false,
      );
      authCtrl.allowLogin = false;
    } else {
      final loginResponse = response.data?['login'];

      await PreferenceManager.setData(
          PreferenceManager.token, loginResponse['token']);
      authCtrl.allowLogin = true;
    }
  }
}
