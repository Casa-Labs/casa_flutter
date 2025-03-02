import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/auth/controller/fit_preferences_controller.dart';
import 'package:casa_flutter/src/auth/view/screens/chip_list.dart';
import 'package:casa_flutter/src/auth/view/widgets/auth_button.dart';
import 'package:casa_flutter/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FitPreferencesScreen extends StatelessWidget {
  FitPreferencesScreen({super.key});

  final fitPreferencesController = Get.put(
    FitPreferencesController(),
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
                    'Fit Preferences',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Obx(
                  () => ChipList(
                    items: fitPreferencesController.fitPreferencesList(),
                    onChipSelected: (selectedId) {
                      fitPreferencesController.selectedFitPreferences(
                        selectedId: selectedId,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Obx(
                    () => AuthButton(
                      type: AuthButtonType.saveFitPreferences,
                      isLoading: fitPreferencesController.isLoading(),
                      onPressed: () {
                        fitPreferencesController.saveFitPreferencesDetails();
                        if (fitPreferencesController.message().isNotEmpty) {
                          showToast(
                            message: fitPreferencesController.message(),
                          );
                          if (fitPreferencesController
                              .isFitPreferencesSaved()) {
                            router.goNamed(RouteNames.deliveryAddress);
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
