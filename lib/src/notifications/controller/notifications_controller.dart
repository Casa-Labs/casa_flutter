import 'dart:convert';

import 'package:casaflutter/src/notifications/model/service/notifications_service.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';
import '../../auth/model/auth_models.dart';
import '../model/notifications_models.dart';

class NotificationsController extends GetxController {

  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //

  List<NotificationByUser> notificationList = <NotificationByUser>[];
  final NotificationsService _notificationsService = NotificationsService();
  RxBool isLoading = false.obs;

  // ========== LIFECYCLE FUNCTIONS ========== //

  @override
  void onInit() {
    super.onInit();
    var loginData = User.fromJson(jsonDecode(PreferenceManager.getString(PreferenceManager.userDetails)!));
    var userId = loginData.id ?? "";
    getNotificationData(userId);
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

}
