import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/common/widgets/common_app_bars.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/src/location/controller/addresses_controller.dart';
import 'package:casaflutter/src/order/controller/order_review_controller.dart';
import 'package:casaflutter/src/profile/view/widgets/logout_confim_action_dialog.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressesList extends StatelessWidget {
  AddressesList({super.key});

  final addressesController = Get.put(
    AddressesController(),
    tag: 'addressController',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Addresses',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Obx(
          () => addressesController.isLoading()
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        if (addressesController.addressList.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: addressesController.addressList.length,
                              itemBuilder: (
                                final BuildContext context,
                                final int index,
                              ) {
                                final address =
                                    addressesController.addressList[index];
                                final fullAddress =
                                    '${address.address}, ${address.landmark}, ${address.city}, ${address.state}, PinCode-${address.pinCode}, ${address.country}';
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 12.0,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      addressesController.selectAddress(
                                        addressId: address.id ?? '',
                                      );
                                    },
                                    child: Dismissible(
                                      key: Key(address.id ?? ''),
                                      confirmDismiss: (dismissDirection) async {
                                        if (dismissDirection ==
                                                DismissDirection.startToEnd ||
                                            dismissDirection ==
                                                DismissDirection.endToStart) {
                                          return await showDialog(
                                            context: context,
                                            builder: (_) => ConfirmActionDialog(
                                              title: 'Delete Address',
                                              message:
                                                  'Are you sure you want to delete?',
                                              confirmText: 'Confirm',
                                              onConfirm: () async {
                                                Navigator.of(context).pop(true);
                                              },
                                            ),
                                          );
                                        } else {
                                          return false;
                                        }
                                      },
                                      onDismissed: (direction) async {
                                        await addressesController.deleteAddress(
                                          addressId: address.id ?? '',
                                        );
                                        if ((addressesController
                                            .message()
                                            .isNotEmpty)) {
                                          showToast(
                                            message:
                                                addressesController.message(),
                                          );
                                        }
                                      },
                                      background: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.white,
                                          size: 35.0,
                                        ),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                          border: Border.all(
                                            width:
                                                address.isSelected ? 4.0 : 1.0,
                                            color: address.isSelected
                                                ? Colors.black
                                                : Colors.grey.shade400,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 8.0,
                                          children: [
                                            Row(
                                              spacing: 8.0,
                                              children: [
                                                Text(
                                                  address.tag ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        router.pushNamed(
                                                          RouteNames.location,
                                                          extra: address,
                                                          pathParameters: {
                                                            'isEdit': 'true',
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              fullAddress,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          Expanded(
                            child: Center(
                              child: Text(
                                'No Address Saved',
                              ),
                            ),
                          ),
                        Container(
                          color: ButtonColor.white,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 30.0,
                          ),
                          child: Obx(
                            () => AnimatedContainer(
                              duration: const Duration(milliseconds: 900),
                              decoration: BoxDecoration(
                                color: addressesController.isBlinking()
                                    ? const Color(0xFF2C9D24)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                onPressed: () async {
                                  HapticFeedback.lightImpact();
                                  addressesController
                                      .checkForAddressSelection();
                                  if (addressesController.isAddressSelected()) {
                                    final address = addressesController
                                        .addressList()
                                        .firstWhere(
                                            (element) => element.isSelected);
                                    await Get.find<OrderReviewController>()
                                        .createOrder(
                                      address: address,
                                      onPaymentSuccess: () async {
                                        final isPopped =
                                            await Navigator.of(context)
                                                .maybePop();
                                        if (isPopped && context.mounted) {
                                          await Navigator.of(context)
                                              .maybePop();
                                        }
                                      },
                                    );
                                  } else {
                                    showToast(
                                      message: addressesController.message(),
                                    );
                                  }
                                },
                                child: Text(
                                  'Continue payment',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ).paddingSymmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 120.0,
                      right: 10.0,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: Size(80.0, 50.0),
                        ),
                        onPressed: () {
                          router.pushNamed(
                            RouteNames.location,
                            pathParameters: {
                              'isEdit': 'false',
                            },
                          );
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              'Add',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
