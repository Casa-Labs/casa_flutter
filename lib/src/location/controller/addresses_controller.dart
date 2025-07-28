import 'dart:async';
import 'dart:convert';

import 'package:casaflutter/src/location/model/get_user_response_model.dart';
import 'package:casaflutter/src/location/model/service/location_service.dart';
import 'package:casaflutter/utils/preference_manager.dart';
import 'package:get/get.dart';

import '../../../utils/bool.dart';
import '../../auth/model/auth_models.dart';

class AddressesController extends GetxController {
  // ========= OBJECTS ============= //
  final LocationService _locationService = LocationService();

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxList<Addresses> addressList = <Addresses>[].obs;
  RxBool isBlinking = false.obs;
  Timer? _blinkingTimer;
  RxBool isAddressSelected = false.obs;

  @override
  void onInit() async {
    await getUserAddressList();
    super.onInit();
  }

  @override
  void dispose() {
    message('');
    isLoading(false);
    addressList().clear();
    isBlinking(false);
    _blinkingTimer?.cancel();
    isAddressSelected(false);
    super.dispose();
  }

  FutureOr<void> getUserAddressList({
    bool? isAdd,
  }) async {
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
      final getUserResponse = await _locationService.getUser(
        userId: userDetails.id ?? '',
      );
      if (getUserResponse != null &&
          (getUserResponse.getUser?.addresses ?? []).isNotEmpty) {
        var sortedAddressesList =
            List<Addresses>.from(getUserResponse.getUser?.addresses ?? [])
              ..sort(
                (b, a) => (a.updatedAt ?? '').compareTo(b.updatedAt ?? ''),
              );
        startBlinking();

        if (isAdd ?? false) {
          final addressId = sortedAddressesList.first.id;
          sortedAddressesList = [
            ...sortedAddressesList.map(
              (address) {
                if (address.id == addressId) {
                  return address.copyWith(
                    isSelected: true,
                  );
                } else {
                  return address.copyWith(
                    isSelected: false,
                  );
                }
              },
            )
          ];
        }

        addressList(sortedAddressesList);
        isLoading(false);
      } else {
        isLoading(false);
        message('Something went wrong...');
      }
    } else {
      isLoading(false);
    }
  }

  void selectAddress({
    required String addressId,
  }) {
    addressList.value = [
      ...addressList.map(
        (address) {
          if (address.id == addressId) {
            return address.copyWith(
              isSelected: true,
            );
          } else {
            return address.copyWith(
              isSelected: false,
            );
          }
        },
      )
    ];
  }

  FutureOr<void> deleteAddress({
    required String addressId,
  }) async {
    final deleteAddressResponse = await _locationService.deleteUserAddress(
      addressId: addressId,
    );
    if ((deleteAddressResponse ?? false) == true) {
      final updatedAddressList = [
        ...addressList..removeWhere((element) => element.id == addressId),
      ];
      addressList(updatedAddressList);
      message('Address deleted successfully');
    }
  }

  void startBlinking() {
    if (_blinkingTimer != null && _blinkingTimer!.isActive) return;
    _blinkingTimer = Timer.periodic(
      const Duration(milliseconds: 800),
      (timer) {
        if (addressList.isEmpty) {
          timer.cancel();
          isBlinking.value = false;
        } else {
          isBlinking.value = !isBlinking.value;
        }
      },
    );
  }

  void checkForAddressSelection() {
    final isSelected = addressList.any((element) => element.isSelected);
    if (addressList.length == 1 || isSelected) {
      isAddressSelected(true);
      Boolean.isPaymentLoading.value = true;
    } else {
      isAddressSelected(false);
      message('Please select delivery address.');
    }
  }
}
