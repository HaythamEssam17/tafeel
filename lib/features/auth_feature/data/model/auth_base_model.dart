import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';

import '../../domain/entities/auth_base_entity.dart';

class AuthBaseModel extends AuthBaseEntity {
  AuthBaseModel({
    super.name,
    super.email,
    super.phone,
    String? address,
    super.active,
    super.verified,
    super.id,
    super.image,
    super.otp,
    super.gender,
    super.token,
    super.isNotified,
    super.referCode,
    super.balance,
  });

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
