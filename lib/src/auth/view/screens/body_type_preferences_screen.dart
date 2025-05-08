import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/auth/controller/body_type_controller.dart';
import 'package:casaflutter/src/auth/view/screens/chip_list.dart';
import 'package:casaflutter/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyTypePreferencesScreen extends StatelessWidget {
  BodyTypePreferencesScreen({super.key});

  final bodyTypeController = Get.put(
    BodyTypeController(),
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
                    'Body Type',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Obx(
                  () => ChipList(
                    items: bodyTypeController.bodyTypeList(),
                    onChipSelected: (selectedId) {
                      bodyTypeController.selectedBodyType(
                        selectedId: selectedId,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Obx(
                    () => AuthButton(
                      type: AuthButtonType.saveBodyTypePreferences,
                      isLoading: bodyTypeController.isLoading(),
                      onPressed: () async {
                        await bodyTypeController.saveBodyTypeDetails();
                        if (bodyTypeController.message().isNotEmpty) {
                          showToast(
                            message: bodyTypeController.message(),
                          );
                          if (bodyTypeController.isBodyTypeSaved()) {
                            router.goNamed(RouteNames.fitPreferences);
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
