import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:flutter/material.dart';

import '../widgets/notification_tile_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Notifications',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Text(
              'New',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NotificationTile(
                    circleImageUrl:
                        'https://wallpapers.com/images/hd/zara-artistic-logo-na3l857kygopljrs.jpg',
                    squareImageUrl:
                        'https://m.media-amazon.com/images/I/A1rAl7nAdxL._AC_UY1100_.jpg',
                    text:
                        'Zara the white croptop is again available in small size...679 people purchased it do you wnat to buy now? 1d',
                  );
                }),
            Text(
              'Last Week',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NotificationTile(
                    circleImageUrl:
                        'https://wallpapers.com/images/hd/zara-artistic-logo-na3l857kygopljrs.jpg',
                    squareImageUrl:
                        'https://m.media-amazon.com/images/I/A1rAl7nAdxL._AC_UY1100_.jpg',
                    text:
                        'Zara 679 people purchased it do you wnat to buy now? 1d',
                  );
                }),
          ],
        ),
      ),
    );
  }
}
