class NotificationModel {
  List<NotificationByUser>? notificationByUser;

  NotificationModel({this.notificationByUser});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notificationByUser'] != null) {
      notificationByUser = <NotificationByUser>[];
      json['notificationByUser'].forEach((v) {
        notificationByUser!.add(NotificationByUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationByUser != null) {
      data['notificationByUser'] =
          notificationByUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationByUser {
  String? id;
  String? title;
  String? message;
  String? firstImage;
  String? secondImage;
  bool? isRead;
  String? createdAt;

  NotificationByUser(
      {this.id,
      this.title,
      this.message,
      this.firstImage,
      this.secondImage,
      this.isRead,
      this.createdAt});

  NotificationByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    firstImage = json['firstImage'];
    secondImage = json['secondImage'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['firstImage'] = firstImage;
    data['secondImage'] = secondImage;
    data['isRead'] = isRead;
    data['createdAt'] = createdAt;
    return data;
  }
}

class DeleteAllNotificationsModel {
  String? deleteAllNotificationsForUser;

  DeleteAllNotificationsModel({this.deleteAllNotificationsForUser});

  DeleteAllNotificationsModel.fromJson(Map<String, dynamic> json) {
    deleteAllNotificationsForUser = json['deleteAllNotificationsForUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deleteAllNotificationsForUser'] = deleteAllNotificationsForUser;
    return data;
  }
}

class DeleteNotificationModel {
  bool? deleteNotificationForUser;

  DeleteNotificationModel({this.deleteNotificationForUser});

  DeleteNotificationModel.fromJson(Map<String, dynamic> json) {
    deleteNotificationForUser = json['deleteNotificationForUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deleteNotificationForUser'] = deleteNotificationForUser;
    return data;
  }
}
