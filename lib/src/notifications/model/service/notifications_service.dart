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
      logg.d('hello i get notifications ------ >>>>> ');
      return notificationResponse;
    } catch (e) {
      logg.e('get error to fetch notifications data $e');
      return NotificationModel();
    }
  }
}
