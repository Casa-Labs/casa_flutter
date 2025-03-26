import 'dart:convert';

import 'package:casaflutterapp/src/auth/model/auth_models.dart';
import 'package:casaflutterapp/src/auth/model/chip_list_model.dart';
import 'package:casaflutterapp/src/auth/model/service/auth_service.dart';
import 'package:casaflutterapp/utils/preference_manager.dart';
import 'package:get/get.dart';

class StylePreferencesController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

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

      // get user details
      final userDetailsData = PreferenceManager.getString(
        PreferenceManager.userDetails,
      );
      var userDetailsMap = <String, dynamic>{};
      if (userDetailsData != null) {
        userDetailsMap = json.decode(userDetailsData.trim());
      }
      final userDetails = User.fromJson(userDetailsMap);
      if (userDetails.id != null) {
        final selectedStyles = [
          ...stylePreferencesList
              .where((e) => e.isSelected)
              .toList()
              .map((style) => style.name),
        ];
        final stylePreferencesResponse = await _authService.addStylePreferences(
          userId: userDetails.id ?? '',
          styles: selectedStyles,
        );
        if (stylePreferencesResponse != null) {
          message('Style preferences saved successfully');
          isLoading(false);
          isStylePreferencesSaved(true);
        } else {
          isLoading(false);
        }
      } else {
        isLoading(false);
      }
    } else {
      message('Please select at-least one style');
      isStylePreferencesSaved(false);
    }
  }
}
