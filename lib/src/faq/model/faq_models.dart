class FAQListModel {
  String question;
  String answer;
  bool isOpen;

  FAQListModel({
    required this.question,
    required this.answer,
    this.isOpen = false,
  });
}
