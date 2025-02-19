import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var newNotifications = <String>[].obs;
  var lastWeekNotifications = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    newNotifications.assignAll(List.generate(5, (index) => 'New Notification $index'));
    lastWeekNotifications.assignAll(List.generate(5, (index) => 'Last Week Notification $index'));
  }

  void removeNotification(int index, bool isNew) {
    if (isNew) {
      newNotifications.removeAt(index);
    } else {
      lastWeekNotifications.removeAt(index);
    }
  }

  void clearAllNotifications() {
    newNotifications.clear();
    lastWeekNotifications.clear();
  }
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //

  // ========== LIFECYCLE FUNCTIONS ========== //

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //
}
