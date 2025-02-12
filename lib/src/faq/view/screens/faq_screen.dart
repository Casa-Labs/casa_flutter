import 'package:casa_flutter/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'FAQ',
      ),
      body: SingleChildScrollView(
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
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemCount: faqCtrl.helpList.length,
              itemBuilder: (context, index) {
                var faqEntry = faqCtrl.helpList[index];
                return Container(
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
                                      color: TextColor.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              if (faqEntry.isOpen)
                                Text(
                                  faqEntry.answer,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                            ],
                          ),
                        ],
                      )),
                      InkWell(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            setState(() {
                              faqEntry.isOpen = !faqEntry.isOpen;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                                faqEntry.isOpen ? Icons.remove : Icons.add,
                                color: Color(0xFF8C8C8C)),
                          ))
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                  thickness: 1,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
