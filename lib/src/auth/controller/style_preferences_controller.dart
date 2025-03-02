import 'package:casa_flutter/src/auth/model/chip_list_model.dart';
import 'package:get/get.dart';

class StylePreferencesController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isStylePreferencesSaved = false.obs;
  RxList<ChipListModel> stylePreferencesList = <ChipListModel>[
    ChipListModel(id: 1, name: 'Casual'),
    ChipListModel(id: 2, name: 'Formal'),
    ChipListModel(id: 3, name: 'Boho'),
    ChipListModel(id: 4, name: 'Chic'),
    ChipListModel(id: 5, name: 'Preppy'),
    ChipListModel(id: 6, name: 'Sporty'),
    ChipListModel(id: 7, name: 'Retro'),
    ChipListModel(id: 8, name: 'Western'),
  ].obs;

  void clearAllControllers() {
    isLoading(false);
    isStylePreferencesSaved(false);
    message('');
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== FUNCTIONS ========== //
  void selectStyle({
    required int selectedId,
  }) {
    stylePreferencesList.value = [
      ...stylePreferencesList.map(
        (style) {
          if (style.id == selectedId) {
            return style.copyWith(
              isSelected: !style.isSelected,
            );
          } else {
            return style;
          }
        },
      ),
    ];
  }

  Future<void> saveStylePreferencesDetails() async {
    if (stylePreferencesList().any((element) => element.isSelected)) {
      isLoading(true);
      message('Style preferences saved successfully');
      isLoading(false);
      isStylePreferencesSaved(true);
    } else {
      message('Please select at-least one style');
      isStylePreferencesSaved(false);
    }
  }
}
