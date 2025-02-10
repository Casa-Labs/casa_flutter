import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:get/get.dart';

import '../../../../network/graphql_client.dart';
import '../../../../utils/preference_manager.dart';
import '../../../../utils/utils.dart';
import '../../../common/widgets/response_dialog.dart';

class HomeService {
  final homeCtrl = Get.find<HomeController>();

  Future<void> getProducts() async {
    const String loginMutation = '''
      mutation Login(\$username: String!, \$password: String!) {
        login(username: \$username, password: \$password) {
          refCode
          token
        }
      }
    ''';

    final variables = {
      "username": '',
      "password": '',
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

    } else {
      final loginResponse = response.data?['login'];

      await PreferenceManager.setData(
          PreferenceManager.token, loginResponse['token']);

    }
  }
}
