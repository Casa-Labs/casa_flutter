import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static const String token = "token";
  static const String userDetails = "userDetails";
  static const String userId = "userId";
  static const String keyIsDarkMode = 'isPrefDarkMode';
  static const String keyAddress = 'userAddress';
  static const String userAddressDetails = 'userAddressDetails';
  static const String isFirstTime = 'isFirstTime';

  static setData(String key, dynamic value) async {
    getStorage().write(key, value);
  }

  static String? getString(String key) {
    final value = getStorage().read(key);
    if (value != null) {
      return "${getStorage().read(key)}";
    } else {
      return null;
    }
  }

  static GetStorage getStorage() {
    return GetStorage();
  }

  static deleteData() async {
    getStorage().erase();
  }

  // Get data as bool from GetStorage
  static bool? getBool(String key) {
    return getStorage().read(key);
  }
}
