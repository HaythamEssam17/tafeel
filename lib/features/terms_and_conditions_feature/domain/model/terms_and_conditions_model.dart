import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';

class TermsAndConditionsModel {
  String? body;

  TermsAndConditionsModel({this.body});

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    try {
      return TermsAndConditionsModel(
        body: json["value"],
      );
    } catch (e) {
      devLog("error when parsing review model $e");
      return TermsAndConditionsModel();
    }
  }
}
