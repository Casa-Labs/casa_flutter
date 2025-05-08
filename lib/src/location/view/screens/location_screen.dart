import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/common/widgets/buttons/custom_button.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/src/location/controller/addresses_controller.dart';
import 'package:casaflutter/src/location/controller/location_controller.dart';
import 'package:casaflutter/src/location/model/get_user_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/common_app_bars.dart';
import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../../../common/widgets/mandatory_title_widget.dart';

class LocationScreen extends StatelessWidget {
  final Addresses? addresses;
  final bool isEdit;
  LocationScreen({
    super.key,
    this.addresses,
    required this.isEdit,
  });

  final locationCtrl = Get.put(
    LocationController(),
  );

  @override
  Widget build(BuildContext context) {
    // call function to load data into controllers
    locationCtrl.fetchAddress(
      addresses: addresses,
    );

    return Scaffold(
      appBar: CommonAppBar(
        title: addresses != null ? 'Update Address' : 'New Address',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                MandatoryTitle(text: 'Tag'),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'eg-Home,Office etc',
                  controller: locationCtrl.tag,
                ),
                SizedBox(height: 30),
                MandatoryTitle(text: 'Address'),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'Address',
                  controller: locationCtrl.streetAddress,
                ),
                SizedBox(height: 30),
                MandatoryTitle(text: 'Landmark'),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'Landmark',
                  controller: locationCtrl.landmark,
                ),
                SizedBox(height: 30),
                MandatoryTitle(text: 'City'),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'City',
                  controller: locationCtrl.city,
                ),
                SizedBox(height: 30),
                MandatoryTitle(text: 'State'),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'State',
                  controller: locationCtrl.state,
                ),
                SizedBox(height: 30),
                MandatoryTitle(text: 'Pincode'),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'Pincode',
                  controller: locationCtrl.zipCode,
                ),
                SizedBox(height: 30),
                MandatoryTitle(text: 'Country'),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'Country',
                  controller: locationCtrl.country,
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => CustomPrimaryButton(
                      button: PrimaryButtons.blackBG,
                      isLoading: locationCtrl.isLoading(),
                      onPressed: () async {
                        locationCtrl.checkForValidations();
                        if (!locationCtrl.isDetailsValid()) {
                          showToast(
                            message: locationCtrl.message(),
                          );
                        } else {
                          if (isEdit) {
                            await locationCtrl.updateAddress();
                          } else {
                            await locationCtrl.addNewAddress();
                          }

                          await Get.find<AddressesController>(
                            tag: 'addressController',
                          ).getUserAddressList(isAdd: !isEdit ? true : false);

                          showToast(
                            message: locationCtrl.message(),
                          );
                          router.pop();
                        }
                      },
                      text: 'Save',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
