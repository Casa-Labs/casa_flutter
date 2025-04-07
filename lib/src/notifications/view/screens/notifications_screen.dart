import 'package:casaflutterapp/src/common/widgets/common_app_bars.dart';
import 'package:casaflutterapp/src/notifications/controller/notifications_controller.dart';
import 'package:casaflutterapp/utils/padding_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/notification_tile_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller =
        Get.put(NotificationsController());
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Notifications',
        actions: [
          IconButton(
            onPressed: () {
              /// To Clear all notifications
              // controller.clearAllNotifications();
              controller.deleteAllNotificationsForUser();
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding:
                EdgeInsets.symmetric(horizontal: PaddingSize.commonPadding),
            child: controller.isLoading()
                ? Center(child: CircularProgressIndicator(color: Colors.black))
                : (controller.notificationList.isNotEmpty)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.notificationList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(controller.notificationList[index].id
                                .toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              // To delete notification one by one
                              // controller.removeNotification(index, false);
                              controller.deleteNotificationForUser(
                                  controller.notificationList[index].id!);
                            },
                            child: NotificationTile(
                              circleImageUrl: controller
                                      .notificationList[index].firstImage ??
                                  "",
                              squareImageUrl: controller
                                      .notificationList[index].secondImage ??
                                  "",
                              text: controller.notificationList[index].title ??
                                  "",
                              message:
                                  controller.notificationList[index].message ??
                                      "",
                            ),
                          );
                        },
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Text('No notification found',
                            style: textTheme.bodyMedium)),
          ),
        ),
      ),
    );
  }
}
