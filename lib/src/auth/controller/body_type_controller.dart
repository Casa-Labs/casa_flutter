import 'dart:convert';

import 'package:casa_flutter/src/auth/model/auth_models.dart';
import 'package:casa_flutter/src/auth/model/chip_list_model.dart';
import 'package:casa_flutter/src/auth/model/service/auth_service.dart';
import 'package:casa_flutter/utils/preference_manager.dart';
import 'package:get/get.dart';

class BodyTypeController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isBodyTypeSaved = false.obs;
  RxList<ChipListModel> bodyTypeList = <ChipListModel>[
    ChipListModel(id: 1, name: 'Hourglass'),
    ChipListModel(id: 2, name: 'Pear'),
    ChipListModel(id: 3, name: 'Apple'),
    ChipListModel(id: 4, name: 'Athletic'),
    ChipListModel(id: 5, name: 'Tall'),
    ChipListModel(id: 6, name: 'Oval'),
    ChipListModel(id: 7, name: 'Petite'),
  ].obs;

  void clearAllControllers() {
    isLoading(false);
    isBodyTypeSaved(false);
    message('');
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== FUNCTIONS ========== //
  void selectedBodyType({
    required int selectedId,
  }) {
    bodyTypeList.value = [
      ...bodyTypeList.map(
        (bodyType) {
          if (bodyType.id == selectedId) {
            return bodyType.copyWith(
              isSelected: !bodyType.isSelected,
            );
          } else {
            return bodyType;
          }
        },
      ),
    ];
  }

  Future<void> saveBodyTypeDetails() async {
    if (bodyTypeList().any((element) => element.isSelected)) {
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
        final selectedBodyTypes = [
          ...bodyTypeList
              .where((e) => e.isSelected)
              .toList()
              .map((bodyType) => bodyType.name),
        ];
        final bodyTypePreferencesResponse =
            await _authService.addBodyTypePreferences(
          userId: userDetails.id ?? '',
          bodyTypes: selectedBodyTypes,
        );
        if (bodyTypePreferencesResponse != null) {
          message('Body type preferences saved successfully');
          isLoading(false);
          isBodyTypeSaved(true);
        } else {
          isLoading(false);
        }
      } else {
        isLoading(false);
      }
    } else {
      message('Please select at-least one body type');
      isBodyTypeSaved(false);
    }
  }
}
