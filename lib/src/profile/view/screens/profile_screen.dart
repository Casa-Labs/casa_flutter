import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/auth/controller/auth_controller.dart';
import 'package:casaflutterapp/src/common/widgets/common_app_bars.dart';
import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
import 'package:casaflutterapp/src/profile/controller/profile_controller.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:casaflutterapp/utils/padding_size.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../widgets/logout_confim_action_dialog.dart';
import '../widgets/share_dialog.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final homeCtrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Profile',
          showBackButton: false,
        ),
        body: SafeArea(
          child: GetX(
            initState: (final _) {
              homeCtrl.getLoggedInUserName();
            },
            builder: (final ProfileController homeCtrl) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      ImageConstants.avatarLogo,
                    ),
                    radius: 35,
                  ),
                  Text(
                    homeCtrl.loggedInUser(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: PaddingSize.commonPadding),
                      child: ListView.builder(
                        itemCount: profileList.length,
                        itemBuilder: (context, index) {
                          final item = profileList[index];
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: ButtonColor.grey,
                                    width: 0.5), // Bottom border only
                              ),
                            ),
                            child: ListTile(
                              title: Text(item.title),
                              titleTextStyle:
                                  Theme.of(context).textTheme.bodySmall,
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
                        backgroundColor: ButtonColor.black,
                        foregroundColor: ButtonColor.white,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * .9,
                          36.0,
                        ),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmActionDialog(
                            title: "Delete Account",
                            message:
                            "Are you sure you want to delete your account? This action cannot be undone.",
                            confirmText: "Delete",
                            isLoading: homeCtrl.isUserDeleteProgress,
                            onConfirm: () async {
                              await homeCtrl.deleteUserCall();
                              if (homeCtrl.message.isNotEmpty) {
                                showToast(
                                  message: homeCtrl.message(),
                                );
                                if (homeCtrl.isUserDeleted()) {
                                  final authController =
                                  Get.put(AuthController());
                                  await authController.logOutUser();
                                  authController.clearAllControllers();
                                  router.goNamed(RouteNames.signIn);
                                }
                              }
                            },
                          ),
                        );
                      },
                      child: Text('Delete Account',)
                  ),
                  const SizedBox(height: 50),
                ],
              );
            },
          ),
        ),
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
      onTap: (context) => context.pushNamed(RouteNames.myOrders, extra: true)),
  ProfileListModel(
      title: 'Order History',
      onTap: (context) => context.pushNamed(RouteNames.myOrders, extra: false)),
  ProfileListModel(
    title: 'Share with a Friend',
    onTap: (context) {
      showDialog(
        context: context,
        builder: (context) => ShareAppDialog(
          appName: 'CASA',
          iosAppLink: 'https://apps.apple.com/app',
          androidAppLink:
              'https://play.google.com/store/apps/details?id=com.casashop.casaflutterappapp',
          shareMessage: 'Check out this amazing app!', // Optional
        ),
      );
    },
  ),
  ProfileListModel(
    title: 'Report an Error',
    onTap: (context) => context.pushNamed(RouteNames.contactUs),
  ),
  ProfileListModel(
    title: 'Talk to a Founder',
    onTap: (context) => context.pushNamed(RouteNames.contactUs),
  ),
  ProfileListModel(
    title: 'Chat with an Associate',
    onTap: (context) => context.pushNamed(RouteNames.contactUs),
  ),
  ProfileListModel(
    title: 'Change Password',
    onTap: (context) => context.pushNamed(RouteNames.changePassword),
  ),
  ProfileListModel(
    title: 'Logout',
    onTap: (context) async {
      showDialog(
        context: context,
        builder: (_) => ConfirmActionDialog(
          title: "Logout",
          message: "Are you sure you want to logout?",
          confirmText: "Logout",
          onConfirm: () async {
            final authController = Get.put(AuthController());
            await authController.logOutUser();
            authController.clearAllControllers();
            router.goNamed(RouteNames.signIn);
          },
        ),
      );
    },
  ),
];
