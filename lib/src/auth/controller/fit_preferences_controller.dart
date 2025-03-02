import 'package:casa_flutter/src/auth/model/chip_list_model.dart';
import 'package:get/get.dart';

class FitPreferencesController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isFitPreferencesSaved = false.obs;
  RxList<ChipListModel> fitPreferencesList = <ChipListModel>[
    ChipListModel(id: 1, name: 'Slim'),
    ChipListModel(id: 2, name: 'Regular'),
    ChipListModel(id: 3, name: 'Relaxed'),
    ChipListModel(id: 4, name: 'Over sized'),
  ].obs;

  void clearAllControllers() {
    isLoading(false);
    isFitPreferencesSaved(false);
    message('');
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== FUNCTIONS ========== //
  void selectedFitPreferences({
    required int selectedId,
  }) {
    fitPreferencesList.value = [
      ...fitPreferencesList.map(
        (fit) {
          if (fit.id == selectedId) {
            return fit.copyWith(
              isSelected: !fit.isSelected,
            );
          } else {
            return fit;
          }
        },
      ),
    ];
  }

  Future<void> saveFitPreferencesDetails() async {
    if (fitPreferencesList().any((element) => element.isSelected)) {
      isLoading(true);
      message('Fit preferences saved successfully');
      isLoading(false);
      isFitPreferencesSaved(true);
    } else {
      message('Please select at-least one Fit preference');
      isFitPreferencesSaved(false);
    }
  }
}
