import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Profile',
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            backgroundImage: AssetImage(ImageConstants.avatarLogo),
            radius: 35,
          ),
          Text('Steve', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: profileList.length,
                itemBuilder: (context, index) {
                  final item = profileList[index];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5), // Bottom border only
                      ),
                    ),
                    child: ListTile(
                      title: Text(item.title),
                      titleTextStyle: Theme.of(context).textTheme.bodySmall,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                      onTap: () => item.onTap(context),
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      dense: true,
                      // visualDensity:
                      //     VisualDensity.compact, // Else theme will be use
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.goNamed(RouteNames.welcomeAuth);
            },
            child: Text('Delete Account'),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class ProfileListModel {
  final String title;
  final void Function(BuildContext) onTap;
  ProfileListModel({required this.title, required this.onTap});
}

List<ProfileListModel> profileList = [
  ProfileListModel(
      title: 'My Orders',
      onTap: (context) => context.pushNamed(RouteNames.myOrders)),
  ProfileListModel(
      title: 'Order History',
      onTap: (context) => context.pushNamed(RouteNames.myOrders)),
  ProfileListModel(
      title: 'Share with a Friend',
      onTap: (context) =>
          Share.share('Check out this amazing product at CASA app now !')),
  ProfileListModel(
      title: 'Report an Error',
      onTap: (context) => context.pushNamed(RouteNames.development)),
  ProfileListModel(
      title: 'Talk to a Founder',
      onTap: (context) => context.pushNamed(RouteNames.development)),
  ProfileListModel(
      title: 'Chat with an Associate',
      onTap: (context) => context.pushNamed(RouteNames.development)),
  ProfileListModel(
      title: 'Logout',
      onTap: (context) => context.goNamed(RouteNames.welcomeAuth)),
];
