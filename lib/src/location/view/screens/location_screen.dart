import 'package:flutter/material.dart';

import '../../../common/widgets/common_app_bars.dart';
import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../../../common/widgets/mandatory_title_widget.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'New Address',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              MandatoryTitle(text: 'Name'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Name',
              ),
              SizedBox(height: 30),
              MandatoryTitle(text: 'Address'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Address',
              ),
              SizedBox(height: 30),
              MandatoryTitle(text: 'Locality'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Locality',
              ),
              SizedBox(height: 30),
              MandatoryTitle(text: 'Landmark'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Landmark',
              ),
              SizedBox(height: 30),
              MandatoryTitle(text: 'City'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'City',
              ),
              SizedBox(height: 30),
              MandatoryTitle(text: 'State'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'State',
              ),
              SizedBox(height: 30),
              MandatoryTitle(text: 'Country'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Country',
              ),
              SizedBox(height: 30),
              MandatoryTitle(text: 'Telephone'),
              SizedBox(height: 5),
              CustomTextFormField(
                hintText: 'Telephone',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
