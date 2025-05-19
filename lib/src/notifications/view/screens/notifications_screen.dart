import 'package:casaflutter/src/common/widgets/common_app_bars.dart';
import 'package:casaflutter/src/notifications/controller/notifications_controller.dart';
import 'package:casaflutter/utils/padding_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/preference_manager.dart';
import '../../../../utils/string_constant.dart';
import '../../../common/widgets/login_first_screen.dart';
import '../widgets/notification_tile_widget.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});
  final NotificationsController controller = Get.put(NotificationsController());
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar:
          (PreferenceManager.getString(PreferenceManager.token) ?? "").isEmpty
              ? AppBar()
              : CommonAppBar(
                  title: 'Notifications',
                  actions: [
                    IconButton(
                      onPressed: () async {
                        // controller.clearAllNotifications();
                        await controller.deleteAllNotificationsForUser();
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                ),
      body: (PreferenceManager.getString(PreferenceManager.token) ?? "").isEmpty
          ? LoginFirstScreen()
          : SafeArea(
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: PaddingSize.commonPadding),
                  child: controller.isLoading()
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.black))
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    color: Colors.red,
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                  onDismissed: (direction) async {
                                    // To delete notification one by one
                                    // controller.removeNotification(index, false);
                                    await controller.deleteNotificationForUser(
                                        controller.notificationList[index].id!);
                                  },
                                  child: NotificationTile(
                                    circleImageUrl: controller
                                            .notificationList[index]
                                            .firstImage ??
                                        ImageConstants.dummyNetworkPortrait,
                                    squareImageUrl: controller
                                            .notificationList[index]
                                            .secondImage ??
                                        ImageConstants.dummyNetworkPortrait,
                                    text: controller
                                            .notificationList[index].title ??
                                        "",
                                    message: controller
                                            .notificationList[index].message ??
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
