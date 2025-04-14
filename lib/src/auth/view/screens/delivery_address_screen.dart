import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/auth/controller/delivery_address_controller.dart';
import 'package:casaflutterapp/src/auth/view/widgets/auth_button.dart';
import 'package:casaflutterapp/src/common/widgets/custom_text_form_field_widget.dart';
import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAddressScreen extends StatelessWidget {
  DeliveryAddressScreen({super.key});

  final deliveryAddressController = Get.put(
    DeliveryAddressController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 80.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'CASA',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Where your style journey begins',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    bottom: 20.0,
                  ),
                  child: Center(
                    child: Text(
                      'Delivery Address',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Street Address'),
                    CustomTextFormField(
                      controller: deliveryAddressController.streetAddress,
                    ),
                    SizedBox(height: 20),
                    Text('Landmark'),
                    CustomTextFormField(
                      controller: deliveryAddressController.landMark,
                    ),
                    SizedBox(height: 20),
                    Text('City'),
                    CustomTextFormField(
                      controller: deliveryAddressController.city,
                    ),
                    SizedBox(height: 20),
                    Text('State'),
                    CustomTextFormField(
                      controller: deliveryAddressController.state,
                    ),
                    SizedBox(height: 20),
                    Text('ZIP Code'),
                    CustomTextFormField(
                      controller: deliveryAddressController.zipCode,
                    ),
                    SizedBox(height: 20),
                    Text('Country'),
                    CustomTextFormField(
                      controller: deliveryAddressController.country,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Obx(
                    () => AuthButton(
                      type: AuthButtonType.start,
                      isLoading: deliveryAddressController.isLoading(),
                      onPressed: () async {
                        await deliveryAddressController
                            .saveDeliveryAddressDetails();
                        if (deliveryAddressController.message().isNotEmpty) {
                          showToast(
                            message: deliveryAddressController.message(),
                          );
                          if (deliveryAddressController
                              .isDeliveryAddressSaved()) {
                            router.goNamed(RouteNames.navigation, extra: false);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
