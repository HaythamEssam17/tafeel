import 'dart:convert';

List<DynamicFormModel> dynamicFormModelFromJson(String str) =>
    List<DynamicFormModel>.from(json.decode(str).map((x) => DynamicFormModel.fromJson(x)));

String dynamicFormModelToJson(List<DynamicFormModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DynamicFormModel {
  String title;
  List<DynamicFormFieldModel> fields;

  DynamicFormModel({
    required this.title,
    required this.fields,
  });

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) => DynamicFormModel(
        title: json["title"],
        fields: List<DynamicFormFieldModel>.from(
          json["fields"].map(
            (x) => DynamicFormFieldModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "fields": List<dynamic>.from(
          fields.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class DynamicFormFieldModel {
  String label;
  String fieldType;
  List<DynamicFormOptionModel>? options;

  DynamicFormFieldModel({
    required this.label,
    required this.fieldType,
    this.options,
  });

  factory DynamicFormFieldModel.fromJson(Map<String, dynamic> json) => DynamicFormFieldModel(
        label: json["label"],
        fieldType: json["fieldType"],
        options: json["options"] == null
            ? []
            : List<DynamicFormOptionModel>.from(
                json["options"]!.map(
                  (x) => DynamicFormOptionModel.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "fieldType": fieldType,
        "options": options == null
            ? []
            : List<DynamicFormOptionModel>.from(
                options!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class DynamicFormOptionModel {
  String color;
  bool isFaulty;
  String optionLabel;
  String optionValue;

  DynamicFormOptionModel({
    required this.color,
    required this.isFaulty,
    required this.optionLabel,
    required this.optionValue,
  });

  factory DynamicFormOptionModel.fromJson(Map<String, dynamic> json) => DynamicFormOptionModel(
        color: json["color"],
        isFaulty: json["is_faulty"],
        optionLabel: json["optionLabel"],
        optionValue: json["optionValue"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "is_faulty": isFaulty,
        "optionLabel": optionLabel,
        "optionValue": optionValue,
      };
}
