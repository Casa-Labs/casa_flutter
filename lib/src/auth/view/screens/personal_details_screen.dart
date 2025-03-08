import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/auth/controller/personal_details_controller.dart';
import 'package:casa_flutter/src/auth/view/widgets/auth_button.dart';
import 'package:casa_flutter/src/common/widgets/custom_text_form_field_widget.dart';
import 'package:casa_flutter/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({super.key});

  final personalDetailsController = Get.put(
    PersonalDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 80.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'CASA',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Where your style journey begins',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    'Personal Details',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('First Name'),
                    CustomTextFormField(
                      controller: personalDetailsController.firstName,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Last Name'),
                    CustomTextFormField(
                      controller: personalDetailsController.lastName,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Phone Number'),
                    CustomTextFormField(
                      controller: personalDetailsController.phoneNumber,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Obx(
                    () => AuthButton(
                      type: AuthButtonType.savePersonalDetails,
                      isLoading: personalDetailsController.isLoading(),
                      onPressed: () async {
                        await personalDetailsController.savePersonalDetails();
                        if (personalDetailsController.message().isNotEmpty) {
                          showToast(
                            message: personalDetailsController.message(),
                          );
                          if (personalDetailsController
                              .isPersonalDetailsSaved()) {
                            router.goNamed(RouteNames.stylePreferences);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
