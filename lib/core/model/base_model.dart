import 'dart:convert';

import '../constants/enums/exception_enums.dart';
import '../network/error_handling/custom_exception.dart';

class BaseModel {
  BaseModel({this.message, this.data});

  String? message;
  dynamic data;

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    try {
      return BaseModel(message: json["message"], data: json["data"]);
    } catch (ex) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
        'cant pars base model',
      );
    }
  }

  Map<String, dynamic> toJson() => {"message": message, "data": data};

  String baseModelToJson(BaseModel data) => json.encode(data.toJson());

  @override
  String toString() {
    return 'BaseModel{message: $message, data: $data}';
  }
}
