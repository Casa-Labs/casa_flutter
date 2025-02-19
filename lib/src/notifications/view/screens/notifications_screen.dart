import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:casa_flutter/src/notifications/controller/notifications_controller.dart';
import 'package:casa_flutter/utils/padding_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/notification_tile_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller = Get.put(NotificationsController());

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Notifications',
        actions: [
          IconButton(
            onPressed: () {
              /// To Clear all notifications
              //controller.clearAllNotifications();
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: PaddingSize.commonPadding),
        child: Column(
          children: [
            Obx(() => Expanded(
              child: ListView(
                children: [
                  if (controller.newNotifications.isNotEmpty) ...[
                    Text(
                      'New',
                      style: TextStyle(fontSize: 20),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.newNotifications.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(controller.newNotifications[index]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            controller.removeNotification(index, true);
                          },
                          child: NotificationTile(
                            circleImageUrl:
                            'https://wallpapers.com/images/hd/zara-artistic-logo-na3l857kygopljrs.jpg',
                            squareImageUrl:
                            'https://m.media-amazon.com/images/I/A1rAl7nAdxL._AC_UY1100_.jpg',
                            text: controller.newNotifications[index],
                          ),
                        );
                      },
                    ),
                  ],
                  if (controller.lastWeekNotifications.isNotEmpty) ...[
                    Text(
                      'Last Week',
                      style: TextStyle(fontSize: 20),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.lastWeekNotifications.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(controller.lastWeekNotifications[index]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            controller.removeNotification(index, false);
                          },
                          child: NotificationTile(
                            circleImageUrl:
                            'https://wallpapers.com/images/hd/zara-artistic-logo-na3l857kygopljrs.jpg',
                            squareImageUrl:
                            'https://m.media-amazon.com/images/I/A1rAl7nAdxL._AC_UY1100_.jpg',
                            text: controller.lastWeekNotifications[index],
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
