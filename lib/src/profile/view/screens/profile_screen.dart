import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/auth/controller/auth_controller.dart';
import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:casa_flutter/src/common/widgets/show_toast.dart';
import 'package:casa_flutter/src/profile/controller/profile_controller.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:casa_flutter/utils/padding_size.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import '../widgets/share_dialog.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final homeCtrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ButtonColor.black,
                      foregroundColor: ButtonColor.white,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width * .9,
                        36.0,
                      ),
                    ),
                    onPressed: () async {
                      await homeCtrl.deleteUserCall();
                      if (homeCtrl.message.isNotEmpty) {
                        showToast(
                          message: homeCtrl.message(),
                        );
                        if (homeCtrl.isUserDeleted()) {
                          final authController = Get.put(AuthController());
                          await authController.logOutUser();
                          authController.clearAllControllers();
                          router.goNamed(RouteNames.signIn);
                        }
                      }
                    },
                    child: homeCtrl.isUserDeleteProgress()
                        ? SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Delete Account',
                          ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            );
          },
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
      onTap: (context) => context.pushNamed(RouteNames.myOrders)),
  ProfileListModel(
      title: 'Order History',
      onTap: (context) => context.pushNamed(RouteNames.myOrders)),
  ProfileListModel(
    title: 'Share with a Friend',
    onTap: (context) {
      showDialog(
        context: context,
        builder: (context) => ShareAppDialog(
          appName: 'CASA',
          iosAppLink: 'https://apps.apple.com/app',
          androidAppLink:
              'https://play.google.com/store/apps/details?id=in.casashop.casa_flutter',
          shareMessage: 'Check out this amazing app!', // Optional
        ),
      );
    },
  ),
  ProfileListModel(
    title: 'Report an Error',
    onTap: (context) => context.pushNamed(RouteNames.development),
  ),
  ProfileListModel(
    title: 'Talk to a Founder',
    onTap: (context) => context.pushNamed(RouteNames.development),
  ),
  ProfileListModel(
    title: 'Chat with an Associate',
    onTap: (context) => context.pushNamed(RouteNames.development),
  ),
  ProfileListModel(
    title: 'Change Password',
    onTap: (context) => context.pushNamed(RouteNames.changePassword),
  ),
  ProfileListModel(
    title: 'Logout',
    onTap: (context) async {
      final authController = Get.put(AuthController());
      await authController.logOutUser();
      authController.clearAllControllers();
      router.goNamed(RouteNames.signIn);
    },
  ),
];
