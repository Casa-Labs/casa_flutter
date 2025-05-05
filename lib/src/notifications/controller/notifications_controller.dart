import 'dart:convert';

import 'package:casaflutter/src/notifications/model/service/notifications_service.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';
import '../../auth/model/auth_models.dart';
import '../../common/widgets/show_toast.dart';
import '../model/notifications_models.dart';

class NotificationsController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //

  List<NotificationByUser> notificationList = <NotificationByUser>[];
  final NotificationsService _notificationsService = NotificationsService();
  RxBool isLoading = false.obs;
  var _userId = "";
  // ========== LIFECYCLE FUNCTIONS ========== //

  @override
  void onInit() {
    super.onInit();
    var loginData = User.fromJson(jsonDecode(
        PreferenceManager.getString(PreferenceManager.userDetails)!));
    _userId = loginData.id ?? "";
    getNotificationData(_userId);
  }

  // ========== UI FUNCTIONS ========== //

  void removeNotification(int index, bool isNew) {
    notificationList.removeAt(index);
  }

  void clearAllNotifications() {
    notificationList.clear();
  }

  // ========== APIs FUNCTIONS ========== //

  Future<void> getNotificationData(String userID) async {
    /// get notification data from server
    isLoading(true);
    update();
    _notificationsService.getNotification(userID).then((value) {
      notificationList = value.notificationByUser!;
      isLoading(false);
      update();
    });
  }

  Future<void> deleteAllNotificationsForUser() async {
    /// delete all notification data from server
    update();
    _notificationsService.deleteAllNotificationsForUser(_userId).then((value) {
      if (value.deleteAllNotificationsForUser != null) {
        showToast(
          message: value.deleteAllNotificationsForUser!,
        );
        getNotificationData(_userId);
      } else {
        showToast(
          message: "Something went wrong, please try again",
        );
      }
    });
  }

  Future<void> deleteNotificationForUser(String notificationId) async {
    /// delete notification data from server
    update();
    _notificationsService
        .deleteNotificationForUser(notificationId)
        .then((value) {
      if (value.deleteNotificationForUser != null &&
          value.deleteNotificationForUser!) {
        showToast(
          message: "Notification deleted successfully",
        );
        getNotificationData(_userId);
      } else {
        showToast(
          message: "Something went wrong, please try again",
        );
      }
    });
  }
}
