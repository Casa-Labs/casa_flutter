import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_text_form_field_widget.dart';
import '../../controller/order_review_controller.dart';

class AddInstructionsWidget extends StatelessWidget {
  AddInstructionsWidget({super.key});
  final orderReviewController = Get.find<OrderReviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height - 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Give Instructions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          // fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  InkWell(
                    overlayColor:
                        WidgetStateProperty.all(ButtonColor.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(40)),
                        child: const Icon(Icons.close)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your Instructions",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CustomTextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: orderReviewController.instructionController,
                    hintText:
                        'Do you have any specific instructions regarding the handling or placement of your package upon delivery?',
                    hintStyle: TextStyle(color: TextColor.grey),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ButtonColor.black,
                foregroundColor: ButtonColor.white,
                fixedSize: Size(
                  MediaQuery.of(context).size.width * .9,
                  36.0,
                ),
              ),
              onPressed: () {
                context.pop();
              },
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
