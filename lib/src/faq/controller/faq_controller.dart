import 'package:casaflutter/src/faq/model/faq_models.dart';
import 'package:get/get.dart';

class FAQController extends GetxController {
  List<FAQListModel> helpList = [
    FAQListModel(
      question: "1. What is Casa?",
      answer:
          "Casa is a clothing marketplace where you can shop from thrift stores and brands. Swipe right to like or left to skip items, and discover amazing clothes curated just for you!",
    ),
    FAQListModel(
        question: "2. How do I create an account on Casa?",
        answer:
            "Download the Casa app and sign up using your email to set up your profile."),
    FAQListModel(
        question: "3. How do I sell my clothes on Casa?",
        answer:
            "If you want to sell your clothes on Casa, email us directly at [your email address], or reach out to us on our Instagram page."),
    FAQListModel(
        question: "4. Does Casa provide international shipping?",
        answer:
            "Casa itself does not handle international shipping. However, individual stores may offer international shipping. You can check the shipping details by scrolling below on the product page."),
    FAQListModel(
        question: "5. What payment methods does Casa accept?",
        answer:
            "Casa accepts debit cards, credit cards, and UPI payments. Please note that we currently do not support Cash on Delivery (COD)."),
    FAQListModel(
        question: "6. Can I return or exchange items?",
        answer:
            '''Returns and exchanges are governed by the store's policy.\n   •  If the item is received damaged, you can report it to us through our com-app chat support or by emailing us.\nEmail Reporting Process:\n  •  Subject of the email: Complaint_Store Name_Date_Order ID \n  •  Body of the email: Mention the order number/ID and describe the issue with the item.'''),
    FAQListModel(
        question: "7. How do I track my order?",
        answer: "Go to Profile > My Orders to view and track your orders."),
    FAQListModel(
        question: "8. How do I contact Casa support?",
        answer:
            '''You can connect with Casa support by:\n  •  Sending us an email\n  •  Reaching out to us via our contact number\n  •  Using our com-app chat support'''),
    FAQListModel(
        question: "9. How do I get my brand or store on Casa?",
        answer:
            "Getting your store or brand listed on Casa is easy! Drop us a mail, contact us via Instagram, or use the support number available on our website."),
  ];
}
