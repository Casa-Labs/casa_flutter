import 'dart:convert';

import 'package:casaflutterapp/src/auth/model/auth_models.dart';
import 'package:casaflutterapp/src/auth/model/chip_list_model.dart';
import 'package:casaflutterapp/src/auth/model/service/auth_service.dart';
import 'package:casaflutterapp/utils/preference_manager.dart';
import 'package:get/get.dart';

class FitPreferencesController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

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
        final selectedFitPreferences = [
          ...fitPreferencesList
              .where((e) => e.isSelected)
              .toList()
              .map((fit) => fit.name),
        ];
        final fitPreferencesResponse = await _authService.addFitPreferences(
          userId: userDetails.id ?? '',
          fitPreferences: selectedFitPreferences,
        );
        if (fitPreferencesResponse != null) {
          message('Fit preferences saved successfully');
          isLoading(false);
          isFitPreferencesSaved(true);
        } else {
          isLoading(false);
        }
      } else {
        isLoading(false);
      }
    } else {
      message('Please select at-least one Fit preference');
      isFitPreferencesSaved(false);
    }
  }
}
