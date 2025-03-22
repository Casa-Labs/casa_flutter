import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/auth/controller/style_preferences_controller.dart';
import 'package:casaflutter/src/auth/view/screens/chip_list.dart';
import 'package:casaflutter/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StylePreferencesScreen extends StatelessWidget {
  StylePreferencesScreen({super.key});

  final stylePreferencesController = Get.put(
    StylePreferencesController(),
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
                    'Style Preferences',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Obx(
                  () => ChipList(
                    items: stylePreferencesController.stylePreferencesList(),
                    onChipSelected: (selectedId) {
                      stylePreferencesController.selectStyle(
                        selectedId: selectedId,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Obx(
                    () => AuthButton(
                      type: AuthButtonType.saveStylePreferences,
                      isLoading: stylePreferencesController.isLoading(),
                      onPressed: () async {
                        await stylePreferencesController
                            .saveStylePreferencesDetails();
                        if (stylePreferencesController.message().isNotEmpty) {
                          showToast(
                            message: stylePreferencesController.message(),
                          );
                          if (stylePreferencesController
                              .isStylePreferencesSaved()) {
                            router.goNamed(RouteNames.bodyTypePreferences);
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
