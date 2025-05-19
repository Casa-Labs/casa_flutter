import '../../../../network/graph_ql_manager.dart';
import '../../../../utils/utils.dart';
import '../notifications_models.dart';

class NotificationsService {
  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<NotificationModel> getNotification(String userID) async {
    NotificationModel notificationResponse;
    try {
      var response = await _graphQLManager.getNotification(userID);
      notificationResponse = NotificationModel.fromJson(response.data!);
      logg.d('Notifications received');
      return notificationResponse;
    } catch (e) {
      logg.e('Error while fetching notifications data $e');
      return NotificationModel();
    }
  }

  Future<DeleteAllNotificationsModel> deleteAllNotificationsForUser(
      String userId) async {
    DeleteAllNotificationsModel deleteAllNotificationsResponse;
    try {
      var response =
          await _graphQLManager.deleteAllNotificationsForUser(userId: userId);
      deleteAllNotificationsResponse =
          DeleteAllNotificationsModel.fromJson(response.data!);
      logg.d('Deleted all notifications');
      return deleteAllNotificationsResponse;
    } catch (e) {
      logg.e('Error while deleting all notifications data $e');
      return DeleteAllNotificationsModel();
    }
  }

  Future<DeleteNotificationModel> deleteNotificationForUser(
      String notificationId) async {
    DeleteNotificationModel deleteNotificationResponse;
    try {
      var response =
          await _graphQLManager.deleteNotificationForUser(id: notificationId);
      deleteNotificationResponse =
          DeleteNotificationModel.fromJson(response.data!);
      logg.d('hello i deleted all notifications ------ >>>>> ');
      return deleteNotificationResponse;
    } catch (e) {
      logg.e('get error to deleted all notifications data $e');
      return DeleteNotificationModel();
    }
  }
}
