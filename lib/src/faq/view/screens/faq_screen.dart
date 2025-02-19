import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../controller/faq_controller.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final faqCtrl = Get.put(FAQController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CommonAppBar(
        title: 'FAQ',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We're here to help you with anything and everything on Casa.\nAt Casa, we're committed to making your shopping and selling experience enjoyable. Check out our FAQs or get in touch with us for further assistance.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "FAQ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Divider(
                color: DividerColor.grey,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                itemCount: faqCtrl.helpList.length,
                itemBuilder: (context, index) {
                  var faqEntry = faqCtrl.helpList[index];
                  return InkWell(
                    overlayColor:
                    WidgetStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      setState(() {
                        faqEntry.isOpen = !faqEntry.isOpen;
                      });
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                faqEntry.question,
                                style:
                                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: TextColor.greyFAQ,
                                          fontWeight: FontWeight.w600,
                                        ),
                              ),
                              faqEntry.isOpen? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                    Text(
                                      faqEntry.answer,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: TextColor.greyFAQ,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ):SizedBox(),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                                faqEntry.isOpen ? Icons.remove : Icons.add,
                                color: Color(0xFF8C8C8C)),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: DividerColor.grey,
                    thickness: 1,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
