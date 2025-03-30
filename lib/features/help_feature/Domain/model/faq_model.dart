List<FAQModel> questionListFromJson(List str) =>
    List<FAQModel>.from(str.map((x) => FAQModel.fromJson(x)));

class FAQModel {
  int id;
  String question;
  String answer;

  FAQModel(
      {required this.id,
      required this.question,
      required this.answer,});

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
