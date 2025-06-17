import 'package:tafeal/core/helpers/shared.dart';

import '../../domain/entities/auth_base_entity.dart';

class AuthBaseModel extends AuthBaseEntity {
  AuthBaseModel({
    String? name,
    String? email,
    String? phone,
    String? address,
    int? active,
    int? verified,
    int? id,
    String? image,
    String? otp,
    String? gender,
    String? token,
    bool? isNotified,
    String? referCode,
    String? balance,
  }) : super(
         id: id,
         image: image,
         name: name,
         active: active,
         email: email,
         phone: phone,
         verified: verified,
         otp: otp,
         gender: gender,
         token: token,
         isNotified: isNotified,
         referCode: referCode,
         balance: balance,
       );

  factory AuthBaseModel.fromJson(Map<String, dynamic> json) {
    try {
      return AuthBaseModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        active: json["active"],
        verified: json["verified"],
        id: json["id"],
        image: json["image"],
        otp: json["otp"].toString(),
        token: json["token"] ?? '',
        gender: json["gender"].toString(),
        balance: json["balance"].toString(),
        referCode:
            json["invite_code"] != null ? json["invite_code"].toString() : "",
        isNotified:
            json["is_notified"] == null
                ? false
                : json["is_notified"] == 1
                ? true
                : false,
      );
    } catch (e) {
      devLog("here is the error in parsing UserBaseModel $e");
      return AuthBaseModel();
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'active': active,
    'verified': verified,
    'id': id,
    'image': image,
    'otp': otp,
    'rate': gender,
    'token': token,
    "balance": balance,
    "invite_code": referCode,
  };
}
