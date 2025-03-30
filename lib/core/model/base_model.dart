import 'dart:convert';

import '../constants/enums/exception_enums.dart';
import '../network/error_handling/custom_exception.dart';

class BaseModel {
  BaseModel({this.code, this.message, this.data, this.otp});

  int? code;

  String? message;
  String? otp;
  dynamic data;

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    try {
      return BaseModel(
        code: json["code"],
        message: json["message"],
        data: json["data"],
      );
    } catch (ex) {
      throw CustomException(CustomStatusCodeErrorType.parsing, 'cant pars base model');
    }
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };

  String baseModelToJson(BaseModel data) => json.encode(data.toJson());

  @override
  String toString() {
    return 'BaseModel{code: $code, message: $message, data: $data}';
  }
}
